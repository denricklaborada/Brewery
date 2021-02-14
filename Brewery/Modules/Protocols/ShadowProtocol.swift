//
//  ShadowProtocol.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit

protocol ShadowProtocol {
    var maskToBounds: Bool { get set }
    var shadowRadius: CGFloat { get set }
    var shadowOpacity: CGFloat { get set }
    var shadowOffset: CGSize { get set }
}
