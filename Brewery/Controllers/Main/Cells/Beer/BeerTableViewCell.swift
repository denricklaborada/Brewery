//
//  BeerTableViewCell.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit
import Reusable
import Kingfisher

class BeerTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var containerView: CustomizableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ data: BeerResponse) {
        selectionStyle = .none
        beerImageView.kf.indicatorType = .activity
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let imageURL = URL(string: data.imageURL) {
                self.beerImageView.kf.setImage(with: imageURL)
            }
            self.titleLabel.text = data.name
            self.subLabel.text = data.tagline
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        containerView.animateTouchDown()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        containerView.animateTouchUp()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            super.touchesEnded(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        containerView.animateTouchUp()
        super.touchesCancelled(touches, with: event)
    }
}
