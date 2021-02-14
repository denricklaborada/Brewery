//
//  LoadMoreTableViewCell.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import UIKit
import Reusable

class LoadMoreTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var loadMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(hasMoreDataToShow: Bool) {
        loadMoreButton.isHidden = !hasMoreDataToShow
    }
}
