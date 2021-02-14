//
//  MainViewController.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit
import Closures

class MainViewController: UIViewController {

    @IBOutlet weak var beerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private let beersService = BeersService()
    
    private var beers: [BeerResponse] = []
    private var hasMoreDataToShow: Bool = true
    private var page = 1
    private var searchQuery = "" {
        didSet {
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTableView()
        searchBar.delegate = self
        loadData()
    }
    
    private func setupEmptyState(isEmpty: Bool) {
        emptyLabel.isHidden = !isEmpty
        beerTableView.bounces = !isEmpty
    }
    
    private func setupTableView() {
        beerTableView.register(cellType: BeerTableViewCell.self)
        beerTableView.register(cellType: LoadMoreTableViewCell.self)
        setupTableViewDataSource()
        setupTableViewDelegate()
    }
    
    private func setupTableViewDataSource() {
        beerTableView.numberOfRows { [weak self] _ -> Int in
            guard let self = self,
                  !self.beers.isEmpty else { return 0 }
            return self.beers.count + 1
        }
        .cellForRow { [weak self] indexPath -> UITableViewCell in
            guard let self = self else {
                return UITableViewCell()
            }
            
            guard indexPath.row < self.beers.count else {
                let cell = self.beerTableView.dequeueReusableCell(for: indexPath, cellType: LoadMoreTableViewCell.self)
                cell.setup(hasMoreDataToShow: self.hasMoreDataToShow)
                cell.loadMoreButton.onTap { [weak self] in
                    self?.loadNextPage()
                }
                return cell
            }
            
            let cell = self.beerTableView.dequeueReusableCell(for: indexPath, cellType: BeerTableViewCell.self)
            cell.setup(self.beers[indexPath.row])
            return cell
        }
    }
    
    private func setupTableViewDelegate() {
        beerTableView.didSelectRowAt { [weak self] indexPath in
            guard let self = self,
                  indexPath.row < self.beers.count else {
                return
            }
            
            self.showDetails(self.beers[indexPath.row])
        }
        .estimatedHeightForRowAt { _ -> CGFloat in
            return 120
        }
        .heightForRowAt { [weak self] indexPath -> CGFloat in
            guard let self = self else { return 0 }
            
            return indexPath.row < self.beers.count ? 120 : 60
        }
    }
    
    private func loadNextPage() {
        page += 1
        loadData(isPaging: true)
    }
    
    private func loadData(isPaging: Bool = false) {
        startLoading()
        beersService.fetchBeers(name: searchQuery, page: page) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.stopAnimating()
            }
            switch result {
            case .success(let response):
                if isPaging {
                    self.beers.append(contentsOf: response)
                } else {
                    self.beers = response
                }
                
                self.hasMoreDataToShow = !(response.isEmpty || response.count % 10 != 0)
                self.setupEmptyState(isEmpty: self.beers.isEmpty)
                self.beerTableView.reloadData()
            case .failure(let error):
                if isPaging {
                    self.page -= 1
                }
                self.showErrorAlert(error)
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        page = 1
        searchQuery = searchBar.text ?? ""
    }
}

// MARK: - Navigation

extension MainViewController {
    private func showDetails(_ beer: BeerResponse) {
        let controller = BeerDetailViewController.instantiate(input: .init(beer: beer))
        navigationController?.pushViewController(controller, animated: true)
    }
}
