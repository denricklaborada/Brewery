//
//  DetailHeaderTableViewCell.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import UIKit
import Reusable

class DetailHeaderTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alcoholLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ data: BeerResponse) {
        beerImageView.kf.indicatorType = .activity
        if let imageURL = URL(string: data.imageURL) {
            beerImageView.kf.setImage(with: imageURL) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.beerImageView.image = response.image
                case .failure:
                    self.beerImageView.image = nil
                    self.beerImageView.isHidden = true
                }
            }
        }
        titleLabel.text = data.name
        taglineLabel.text = data.tagline
        
        let cleanedDate = data.firstBrewed.toCleanedDate()
        dateLabel.text = cleanedDate.isEmpty ? "" : "First Brewed: \(cleanedDate)"
        alcoholLabel.text = "\(data.alcohol)% alc."
    }
}
