//
//  BeerDetailViewController.swift
//  Brewery
//
//  Created by Denrick on 2/12/21.
//

import UIKit

class BeerDetailViewController: UIViewController {

    struct Input {
        var beer: BeerResponse
    }
    
    @IBOutlet weak var detailTableView: UITableView!
    
    private var beer: BeerResponse!
    private let sections: [BeerDetailSections] = [.header, .foodPairs, .beerDescription]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        detailTableView.register(cellType: DetailHeaderTableViewCell.self)
        detailTableView.register(cellType: FoodPairsTableViewCell.self)
        detailTableView.register(cellType: BeerDescriptionTableViewCell.self)
        setupTableViewDataSource()
        setupTableViewDelegate()
    }
    
    private func setupTableViewDataSource() {
        detailTableView.numberOfRows { [weak self] _ -> Int in
            guard let self = self else { return 0 }
            return self.sections.count
        }
        .cellForRow { [weak self] indexPath -> UITableViewCell in
            guard let self = self else {
                return UITableViewCell()
            }
            
            switch self.sections[indexPath.row] {
            case .header:
                let cell = self.detailTableView.dequeueReusableCell(for: indexPath, cellType: DetailHeaderTableViewCell.self)
                cell.setup(self.beer)
                return cell
            case .foodPairs:
                let cell = self.detailTableView.dequeueReusableCell(for: indexPath, cellType: FoodPairsTableViewCell.self)
                cell.setup(self.beer.foodPairing)
                return cell
            case .beerDescription:
                let cell = self.detailTableView.dequeueReusableCell(for: indexPath, cellType: BeerDescriptionTableViewCell.self)
                cell.setup(self.beer.beerDescription)
                return cell
            }
        }
    }
    
    private func setupTableViewDelegate() {
        detailTableView.heightForRowAt { [weak self] indexPath -> CGFloat in
            guard let self = self else { return 0 }
            return self.sections[indexPath.row].height
        }
    }
}

extension BeerDetailViewController {
    static func instantiate(input: Input) -> BeerDetailViewController {
        let controller = StoryboardScene.BeerDetail.initialScene.instantiate()
        controller.beer = input.beer
        controller.hidesBottomBarWhenPushed = true
        return controller
    }
}
