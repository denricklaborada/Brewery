//
//  BeerDescriptionTableViewCell.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import UIKit
import Reusable

class BeerDescriptionTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(_ text: String) {
        descriptionLabel.text = text
    }
}
