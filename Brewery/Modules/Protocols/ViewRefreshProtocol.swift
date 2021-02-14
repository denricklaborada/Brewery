//
//  ViewRefreshProtocol.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit

protocol ViewRefreshProtocol {
    func refreshView()
}

extension ViewRefreshProtocol where Self: UIView {
    func refreshView() {
        setNeedsDisplay()
        setNeedsLayout()
    }
}
