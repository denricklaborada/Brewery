//
//  AlertView.swift
//  Brewery
//
//  Created by Denrick on 2/12/21.
//

import UIKit
import Reusable
import Closures

class AlertView: UIView, NibLoadable {
    @IBOutlet weak var containerView: CustomizableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    var didTapCTA: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(title: String, description: String, buttonTitle: String = "Close") {
        blurBackground()
        
        titleLabel.isHidden = title.isEmpty
        subLabel.isHidden = description.isEmpty
        ctaButton.setTitle(buttonTitle.isEmpty ? "Close" : buttonTitle, for: .normal)
        titleLabel.text = title
        subLabel.text = description
        
        ctaButton.onTap { [weak self] in
            self?.removeView()
            self?.didTapCTA?()
        }
    }
    
    private func blurBackground() {
        backgroundColor = .clear
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }

    func removeView() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 0
            self.containerView.transform = .init(scaleX: 0.8, y: 0.8)
            self.backgroundColor = .clear
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
