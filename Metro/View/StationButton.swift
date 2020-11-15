//
//  StationButton.swift
//  Metro
//
//  Created by Egor Malyshev on 01.11.2020.
//

import UIKit

//@IBDesignable
class StationButton: UIButton {
    
    var isSetuped = false
    
    @IBInspectable var background: UIColor = .clear {
        didSet {
            setButtonBackground(color: background)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setButtonBackground(color: background)
        
        if isSetuped { return }
        isSetuped = true
    }
    
    func setButtonBackground(color: UIColor){
        self.imageView?.backgroundColor = color
    }

    
}
