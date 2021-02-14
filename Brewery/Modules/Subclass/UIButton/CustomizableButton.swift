//
//  CustomizableButton.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit

@IBDesignable
class CustomizableButton: UIButton {
        
    @IBInspectable var selectedBackgroundColor: UIColor = .clear
    
    @IBInspectable var nonSelectedBackgroundColor: UIColor = .clear {
        didSet {
            backgroundColor = nonSelectedBackgroundColor
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = .clear {
        didSet {
            setTitleColor(selectedTextColor, for: .selected)
        }
    }
    
    @IBInspectable var nonSelectedTextColor: UIColor = .clear {
        didSet {
            setTitleColor(nonSelectedTextColor, for: .normal)
        }
    }
    
    @IBInspectable var selectedButtonImage: UIImage? {
        didSet {
            setImage(selectedButtonImage, for: .selected)
        }
    }
    
    @IBInspectable var nonSelectedButtonImage: UIImage? {
        didSet {
            setImage(nonSelectedButtonImage, for: .normal)
        }
    }
    
    @IBInspectable var animatesWhenTapped: Bool = true
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = selectedBackgroundColor
                setTitleColor(selectedTextColor, for: .normal)
            } else {
                backgroundColor = nonSelectedBackgroundColor
                setTitleColor(nonSelectedTextColor, for: .normal)
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard animatesWhenTapped else { return true }
        animateTouchDown()
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard animatesWhenTapped else { return }
        animateTouchUp()
    }
}

extension CustomizableButton: BorderProtocol, ViewRefreshProtocol {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            refreshView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
            refreshView()
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            guard let currentBorderColor = layer.borderColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentBorderColor)
        }
        
        set {
            layer.borderColor = newValue.cgColor
            refreshView()
        }
    }
}

extension CustomizableButton: ShadowProtocol {
    
    @IBInspectable var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get {
            return CGFloat(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}
