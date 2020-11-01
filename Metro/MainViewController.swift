//
//  ViewController.swift
//  Metro
//
//  Created by Egor Malyshev on 28.10.2020.
//

import UIKit

class MainViewController: UIViewController {

    let graph = GraphCreator().create()
    
    var temporaryTag: Int = 0
    var fromStation: Int = 0 {
        didSet {
            if fromStation != 0 && toStation != 0{
                getPath()
            }
        }
    }
    var toStation: Int = 0{
        didSet {
            if fromStation != 0 && toStation != 0{
                getPath()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scheme = MetroScheme.loadFromNIB()
        scheme.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(scheme)
        
        let stations = scheme.subviews.filter{$0 is StationButton}
        for s in stations{
            if let s = s as? StationButton{
                s.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
                s.addAction(UIAction(handler: { (action) in
                    if let stationButton = action.sender as? StationButton{
                        self.temporaryTag = stationButton.tag
                    }
                }), for: .touchUpInside)
            }
        }
        
    }
    
    func getPath(){
        if let from = graph.stationWithTag(fromStation), let to = graph.stationWithTag(toStation), let path = graph.shortestPath(source: from, destination: to){
            print(path.description)
            fromStation = 0
            toStation = 0
        }
    }
    
    @objc func showAlert(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let from = UIAlertAction(title: "Отсюда", style: .default) { (action) in
            if self.temporaryTag != 0{
                print("Отсюда")
                self.fromStation = self.temporaryTag
                self.temporaryTag = 0
            }
        }
        let to = UIAlertAction(title: "Сюда", style: .default) { (action) in
            if self.temporaryTag != 0{
                print("Отсюда")
                self.toStation = self.temporaryTag
                self.temporaryTag = 0
            }
        }
        alert.addAction(from)
        alert.addAction(to)
        present(alert, animated: true, completion: nil)
    }


}


