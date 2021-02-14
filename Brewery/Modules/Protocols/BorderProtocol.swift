//
//  BorderProtocol.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit

protocol BorderProtocol {
    
    var cornerRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
    var shadowColor: UIColor { get set }
    var shadowRadius: CGFloat { get set }
}

extension BorderProtocol where Self: UIView {
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor {
        get {
            guard let currentBorderColor = layer.borderColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentBorderColor)
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    var shadowColor: UIColor {
        get {
            guard let currentShadowColor = layer.shadowColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentShadowColor)
        }
        
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
}
