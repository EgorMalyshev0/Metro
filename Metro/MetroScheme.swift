//
//  MetroScheme.swift
//  Metro
//
//  Created by Egor Malyshev on 01.11.2020.
//

import UIKit

class MetroScheme: UIView {

    static func loadFromNIB() -> MetroScheme {
        let nib = UINib(nibName: "MetroScheme", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! MetroScheme 
    }

}
