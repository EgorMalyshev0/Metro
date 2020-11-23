//
//  PathDetailsViewController.swift
//  Metro
//
//  Created by Egor Malyshev on 18.11.2020.
//

import UIKit

class PathDetailsViewController: UIViewController {

    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var parentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var path: Path?
    
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showPath()
    }
    
    func showPath(){
        guard path != nil else { return }
        var previousLabelY: CGFloat = 50
        for i in 0...path!.array.count - 1 {
            var standartHeight: CGFloat = 0
            if i == 0 {
            } else if previousEdgeIsTransition(stationWithIndex: i){
                standartHeight = 120
            } else if i == 1 || i == path!.array.count - 1 || previousEdgeIsTransition(stationWithIndex: i - 1) || previousEdgeIsTransition(stationWithIndex: i + 1){
                standartHeight = 45
            } else {
                standartHeight = 30
            }
            let label = createStationLabel(i, standartHeight, &previousLabelY)
            parentView.addSubview(label)
            let circleView = createCircleView(label, i)
            parentView.addSubview(circleView)
            let timeLabel = createTimeLabel(label, i)
            parentView.addSubview(timeLabel)
//            parentView.insertSubview(timeLabel, at: 1)
            
            if i != 0 && !previousEdgeIsTransition(stationWithIndex: i){
                let pathView = createPathView(circleView, standartHeight: standartHeight)
                parentView.addSubview(pathView)
                parentView.insertSubview(pathView, belowSubview: circleView)
            }
            if previousEdgeIsTransition(stationWithIndex: i) {
                let transitionView = createTransitionView(label, i, standartHeight)
                parentView.addSubview(transitionView)
                parentView.insertSubview(transitionView, belowSubview: label)
            }
            if i == path!.array.count - 1 {
                parentViewHeight.isActive = false
                parentView.frame.size.height = label.frame.origin.y + label.frame.height + 50
            }
        }
    }
    
    private func previousEdgeIsTransition(stationWithIndex i: Int) -> Bool {
        if i != 0 {
            return path!.array[i].edgeWith(destination: path!.array[i - 1])!.isTransition
        } else { return false }
    }
    
    private func createStationLabel(_ index: Int,_ standartHeight: CGFloat,_ y: inout CGFloat) -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: y + standartHeight, width: parentView.bounds.width - 100, height: 20)
        y = label.frame.origin.y
        label.text = path!.array[index].name
        if index == 0 || index == path!.array.count - 1 || path!.array[index].edgeWith(destination: path!.array[index + 1])!.isTransition || path!.array[index].edgeWith(destination: path!.array[index - 1])!.isTransition {
            label.font = UIFont.boldSystemFont(ofSize: 17)
        } else {
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .lightGray
        }
        return label
    }
    
    private func createCircleView(_ label: UILabel,_ index: Int) -> UIView {
        let circleView = UIView(frame: CGRect(x: label.frame.origin.x - 30, y: label.center.y - 4, width: 8, height: 8))
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.backgroundColor = path!.array[index].lineColor
        return circleView
    }
    
    private func createPathView(_ circleView: UIView, standartHeight: CGFloat) -> UIView {
        let pathView = UIView(frame: CGRect(x: circleView.center.x - 2, y: circleView.center.y - standartHeight, width: 4, height: standartHeight))
        pathView.backgroundColor = circleView.backgroundColor
        return pathView
    }
    
    private func createTransitionView(_ label: UILabel,_ index: Int,_ standartHeight: CGFloat) -> UIView {
        let transitionView = UIView.fromNIB() as TransitionView
        transitionView.frame.origin = CGPoint(x: label.frame.origin.x, y: label.frame.origin.y - standartHeight / 2 - label.frame.height)
        return transitionView
    }
    
    private func createTimeLabel(_ label: UILabel,_ index: Int) -> UILabel {
        let timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 15, y: label.frame.origin.y,width: label.frame.origin.x - 30,height: 20)
        let text = path?.countCurrentTimeOnStation(index: index)
        timeLabel.text = text
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = .darkGray
        return timeLabel
    }

}
