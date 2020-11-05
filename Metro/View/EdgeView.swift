//
//  EdgeView.swift
//  Metro
//
//  Created by Egor Malyshev on 31.10.2020.
//

import UIKit

@IBDesignable
class EdgeView: UIView {

    var isSetuped = false
    
    @IBInspectable var angle: Double = 0 {
        didSet {
            rotateView(angle: angle)
        }
    }
    
    @IBInspectable var topRightCornerRadius: CGFloat = 0 {
        didSet {
            setTopRightCornerRadius(radius: topRightCornerRadius)
        }
    }
    
    @IBInspectable var bottomLeftCornerRadius: CGFloat = 0 {
        didSet {
            setBottomLeftCornerRadius(radius: bottomLeftCornerRadius)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rotateView(angle: angle)
        
        if isSetuped { return }
        isSetuped = true
    }
    
    func rotateView(angle: Double) {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(.pi / 180 * angle))
    }
    
    func setTopRightCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func setBottomLeftCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
}

