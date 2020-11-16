//
//  MetroScheme.swift
//  Metro
//
//  Created by Egor Malyshev on 01.11.2020.
//

import UIKit

class MetroScheme: UIView {
    
    @IBOutlet weak var hiddenEdge110: EdgeView!
    @IBOutlet weak var hiddenEdge110_1: EdgeView!
    @IBOutlet weak var hiddenEdge111: EdgeView!
    @IBOutlet weak var hiddenEdge112: EdgeView!
    @IBOutlet weak var hiddenEdge127: EdgeView!
    @IBOutlet weak var hiddenEdge128: EdgeView!
    @IBOutlet weak var hiddenEdge142: EdgeView!
    @IBOutlet weak var hiddenEdge160: EdgeView!
    
    func checkHiddenEdges(edges: [Edge]){
        for e in edges{
            for i in [hiddenEdge127,
                      hiddenEdge128,
                      hiddenEdge112,
                      hiddenEdge160,
                      hiddenEdge111,
                      hiddenEdge110,
                      hiddenEdge110_1,
                      hiddenEdge142]{
                if e.tag == i!.tag{
                    i!.isHidden = false
                }
            }
        }
        if edges.contains(where: {$0.tag == 110}) && edges.contains(where: {$0.destination.tag == 43}) {
            hiddenEdge110.isHidden = true
            hiddenEdge110_1.isHidden = true
        }
        if edges.contains(where: {$0.tag == 142}) && edges.contains(where: {$0.destination.tag == 53}) {
            hiddenEdge142.isHidden = true
        }
        if edges.contains(where: {$0.tag == 111}) && edges.contains(where: {$0.destination.tag == 51}) {
            hiddenEdge111.isHidden = true
        }
        if edges.contains(where: {$0.tag == 160}) && edges.contains(where: {$0.destination.tag == 12}) {
            hiddenEdge160.isHidden = true
        }
        if edges.contains(where: {$0.tag == 112}) && edges.contains(where: {$0.destination.tag == 30}) {
            hiddenEdge112.isHidden = true
        }
        if edges.contains(where: {$0.tag == 128}) && edges.contains(where: {$0.destination.tag == 64}) {
            hiddenEdge128.isHidden = true
        }
        if edges.contains(where: {$0.tag == 127}) && edges.contains(where: {$0.destination.tag == 42}) {
            hiddenEdge127.isHidden = true
        }
    }
    
    func rebootHiddenEdges(){
        hiddenEdge127.isHidden = true
        hiddenEdge128.isHidden = true
        hiddenEdge112.isHidden = true
        hiddenEdge160.isHidden = true
        hiddenEdge111.isHidden = true
        hiddenEdge110.isHidden = true
        hiddenEdge110_1.isHidden = true
        hiddenEdge142.isHidden = true
    }
}

extension UIView {
    class func fromNIB<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
