//
//  CustomizableView.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit

// swiftlint:disable all
@IBDesignable
class CustomizableView: UIView {
    
    private var _isRoundedTopLeftCorner: Bool = false
    private var _isRoundedTopRightCorner: Bool = false
    private var _isRoundedBottomLeftCorner: Bool = false
    private var _isRoundedBottomRightCorner: Bool = false
    
    @IBInspectable var primaryColor: UIColor = .clear {
        didSet {
            if let layer = layer as? CAGradientLayer {
                layer.colors = [primaryColor.cgColor, secondaryColor.cgColor]
            }
        }
    }
    
    @IBInspectable var secondaryColor: UIColor = .clear {
        didSet {
            if let layer = layer as? CAGradientLayer {
                layer.colors = [primaryColor.cgColor, secondaryColor.cgColor]
            }
        }
    }
    
    @IBInspectable var gradientStart: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet {
            if let layer = layer as? CAGradientLayer {
                layer.startPoint = gradientStart
            }
        }
    }
    
    @IBInspectable var gradientEnd: CGPoint = CGPoint(x: 1.0, y: 0.0) {
        didSet {
            if let layer = layer as? CAGradientLayer {
                layer.endPoint = gradientEnd
            }
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

extension CustomizableView: BorderProtocol, ViewRefreshProtocol {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
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
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.layer.borderColor = newValue.cgColor
                self.refreshView()
            },
            completion: nil)
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
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
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
    
    @IBInspectable private var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable private var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var isRoundedTopLeftCorner: Bool {
        get {
            return _isRoundedTopLeftCorner
        }
        
        set {
            _isRoundedTopLeftCorner = newValue
            setupMaskCorners()
        }
    }
    
    @IBInspectable var isRoundedTopRightCorner: Bool {
        get {
            return _isRoundedTopRightCorner
        }
        
        set {
            _isRoundedTopRightCorner = newValue
            setupMaskCorners()
        }
    }
    
    @IBInspectable var isRoundedBottomLeftCorner: Bool {
        get {
            return _isRoundedBottomLeftCorner
        }
        
        set {
            _isRoundedBottomLeftCorner = newValue
            setupMaskCorners()
        }
    }
    
    @IBInspectable var isRoundedBottomRightCorner: Bool {
        get {
            return _isRoundedBottomRightCorner
        }
        
        set {
            _isRoundedBottomRightCorner = newValue
            setupMaskCorners()
        }
    }
    
    private func setupMaskCorners() {
        var array = [CACornerMask]()
        if isRoundedTopLeftCorner {
            array.append(CACornerMask.layerMinXMinYCorner)
        }
        
        if isRoundedTopRightCorner {
            array.append(CACornerMask.layerMaxXMinYCorner)
        }
        
        if isRoundedBottomLeftCorner {
            array.append(CACornerMask.layerMinXMaxYCorner)
        }
        
        if isRoundedBottomRightCorner {
            array.append(CACornerMask.layerMaxXMaxYCorner)
        }
        
        if array.count == 1 {
            layer.maskedCorners = [array[0]]
        } else if array.count == 2 {
            layer.maskedCorners = [array[0], array[1]]
        } else if array.count == 3 {
            layer.maskedCorners = [array[0], array[1], array[2]]
        } else if array.count == 4 {
            layer.maskedCorners = [array[0], array[1], array[2], array[3]]
        } else {
            
        }
    }
    
}
