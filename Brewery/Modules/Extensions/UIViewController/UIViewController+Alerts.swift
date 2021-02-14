//
//  UIViewController+Alerts.swift
//  Brewery
//
//  Created by Denrick on 2/12/21.
//

import UIKit
import SnapKit

extension UIViewController {
    @discardableResult
    func showErrorAlert(_ error: APIError) -> AlertView? {
        guard let topView = view.window,
            !topView.subviews.contains(where: { $0 is AlertView }) else {
                return nil
        }
        
        let alertView = AlertView.loadFromNib()
        alertView.setup(title: error.errorTitle, description: error.errorMessage)
        
        UIView.transition(with: topView, duration: 0.2, options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
            topView.addSubview(alertView)
        }, completion: nil)
        topView.bringSubviewToFront(alertView)
        alertView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        alertView.alpha = 0
        alertView.containerView.transform = .init(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            alertView.alpha = 1
            alertView.containerView.transform = .identity
        }, completion: nil)
        
        return alertView
    }
}
