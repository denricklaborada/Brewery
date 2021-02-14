//
//  UIViewController+Loading.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    func startLoading() {
        startAnimating(.init(width: 50, height: 50), type: .circleStrokeSpin, color: .white, backgroundColor: UIColor.black.withAlphaComponent(0.4), fadeInAnimation: .none)
    }
}
