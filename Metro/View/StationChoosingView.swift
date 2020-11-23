//
//  StationChoosingView.swift
//  Metro
//
//  Created by Egor Malyshev on 22.11.2020.
//

import UIKit

class StationChoosingView: UIView {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var lineNameLabel: UILabel!
    @IBOutlet weak var lineColorView: UIView!
    @IBOutlet weak var lineNumberLabel: UILabel!
    @IBOutlet weak var fromStationButton: UIButton!
    @IBOutlet weak var toStationButton: UIButton!
    
    var station: Station? {
        didSet{
            guard station != nil else { return }
            stationNameLabel.text = station!.name
            lineNameLabel.text = station!.lineName
            lineColorView.backgroundColor = station!.lineColor
            lineNumberLabel.text = "\(station!.lineNumber)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fromStationButton.layer.cornerRadius = fromStationButton.frame.height / 2
        toStationButton.layer.cornerRadius = toStationButton.frame.height / 2
        lineColorView.layer.cornerRadius = 3
    }
}
