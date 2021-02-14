//
//  FoodPairsTableViewCell.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import UIKit
import Reusable

class FoodPairsTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var listLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(_ list: [String]) {
        var foodPairsString = ""
        for item in list {
            if item == list.last {
                foodPairsString += item
            } else {
                foodPairsString += "\(item), "
            }
        }
        listLabel.text = foodPairsString
    }
}
