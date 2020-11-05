//
//  MetroScheme.swift
//  Metro
//
//  Created by Egor Malyshev on 01.11.2020.
//

import UIKit

class MetroScheme: UIView {
    
}

extension UIView {
    class func fromNIB<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
