//
//  UIView+Animations.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import UIKit

extension UIView {
    func animateVisibility(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            isHidden ? self?.hide() : self?.show()
        }
    }
    
    func show() {
        if !isHidden,
            alpha == 1 {
            return
        }
        
        alpha = 0
        isHidden = true
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
            self?.alpha = 1
            self?.isHidden = false
            }, completion: nil)
    }
    
    func hide() {
        if isHidden,
            alpha == 0 {
            return
        }
        
        alpha = 1
        isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
            self?.alpha = 0
            self?.isHidden = true
            }, completion: nil)
    }
    
    func animateAlpha(value: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
        self?.alpha = value
        }, completion: nil)
    }
    
    func animateShadow(isShown: Bool, timing: CAMediaTimingFunctionName = .default, duration: CFTimeInterval = 0.3, lowValue: Float = 0) {
        let shadowOpacityAnimation = CABasicAnimation()
        shadowOpacityAnimation.fromValue = isShown ? lowValue : layer.shadowOpacity
        shadowOpacityAnimation.toValue = isShown ? layer.shadowOpacity : lowValue
        shadowOpacityAnimation.isRemovedOnCompletion = false
        shadowOpacityAnimation.fillMode = .forwards
        shadowOpacityAnimation.duration = duration
        shadowOpacityAnimation.timingFunction = CAMediaTimingFunction(name: timing)
        layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
    }
    
    func animateTouchDown(duration: Double = 0.1) {
        transform = .identity
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.transform = .init(scaleX: 0.9, y: 0.9)
            }, completion: nil)
        animateShadow(isShown: false, timing: .easeOut, duration: duration, lowValue: layer.shadowOpacity / 3.0)
    }
    
    func animateTouchUp(duration: Double = 0.2) {
        transform = .init(scaleX: 0.9, y: 0.9)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.transform = .identity
            }, completion: nil)
        animateShadow(isShown: true, timing: .easeOut, duration: duration, lowValue: layer.shadowOpacity / 3.0)
    }
    
    func shake() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 4, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 4, y: center.y))
        
        layer.add(animation, forKey: "position")
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}
