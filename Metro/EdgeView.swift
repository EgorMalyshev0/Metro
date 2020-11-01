//
//  EdgeView.swift
//  Metro
//
//  Created by Egor Malyshev on 31.10.2020.
//

import UIKit

//@IBDesignable
class EdgeView: UIView {

    var isSetuped = false
    
    @IBInspectable var angle: Double = 0 {
        didSet {
            rotateView(angle: angle)
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
}

