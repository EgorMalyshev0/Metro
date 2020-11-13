//
//  AViewController.swift
//  Metro
//
//  Created by Egor Malyshev on 04.11.2020.
//

import UIKit

class MainViewController: UIViewController {

    let graph = GraphCreator().create()
    var scroll = UIScrollView()
    var scheme = UIView()
    var imgViews = [UIImageView]()
        
    var temporaryTag: Int = 0
    var fromStation: Int = 0 {
        didSet {
            if fromStation != 0 {
                imgViews.forEach {$0.removeFromSuperview()}
                imgViews.removeAll()
                showPicture(.a)
                showPicture(.b)
            }
            if toStation != 0 {
                getPath()
            }
        }
    }
    var toStation: Int = 0{
        didSet {
            if toStation != 0 {
                imgViews.forEach {$0.removeFromSuperview()}
                imgViews.removeAll()
                showPicture(.a)
                showPicture(.b)
            }
            if fromStation != 0 {
                getPath()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        self.scroll = scroll
        view.addSubview(scroll)
        let scheme = UIView.fromNIB() as MetroScheme
        self.scheme = scheme
        scroll.addSubview(scheme)
        
        configurateScheme()
        countMinScale()
        centerScheme()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        centerScheme()
    }
    
    func configurateScheme() {
        scroll.contentSize = scheme.bounds.size
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
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
    
    func countMinScale(){
        let bounds = self.view.bounds.size
        let schemeBounds = scheme.bounds.size
        let xscale = bounds.width / schemeBounds.width
        let yscale = bounds.height / schemeBounds.height
        let minScale = min(xscale, yscale)
        scroll.minimumZoomScale = minScale
        scroll.maximumZoomScale = 2
        scroll.zoomScale = minScale
    }
    
    func centerScheme(){
        let bounds = self.view.bounds.size
        var schemeFrame = scheme.frame
        if schemeFrame.size.width < bounds.width {
            schemeFrame.origin.x = (bounds.width - schemeFrame.size.width) / 2
        } else {
            schemeFrame.origin.x = 0
        }
        if schemeFrame.size.height < bounds.height {
            schemeFrame.origin.y = (bounds.height - schemeFrame.size.height) / 2
        } else {
            schemeFrame.origin.y = 0
        }
        scheme.frame = schemeFrame
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
                print("Сюда")
                self.toStation = self.temporaryTag
                self.temporaryTag = 0
            }
        }
        alert.addAction(from)
        alert.addAction(to)
        present(alert, animated: true, completion: nil)
    }
    
    func showPicture(_ pictureName: PictureName){
        var check = 0
        if pictureName == .a{
            check = fromStation
        } else {
            check = toStation
        }
        guard check != 0 else {return}
            guard let button = scheme.subviews.filter({$0.tag == check}).first as? StationButton else {return}
            let fr = button.frame
            let center = button.imageView!.center
            let size = CGSize(width: 75, height: 90)
            if button.semanticContentAttribute == .forceRightToLeft {
                let origin = CGPoint(x: fr.origin.x + center.x - size.width / 2, y: fr.origin.y - size.height + center.y)
                let img = UIImageView(frame: CGRect(origin: origin, size: size))
                img.image = UIImage(named: pictureName.rawValue)
                scheme.addSubview(img)
                imgViews.append(img)
            } else {
                let origin = CGPoint(x: fr.origin.x + center.x - size.width / 2, y: fr.origin.y - size.height + center.y)
                let img = UIImageView(frame: CGRect(origin: origin, size: size))
                img.image = UIImage(named: pictureName.rawValue)
                scheme.addSubview(img)
                imgViews.append(img)
            }
    }

    func getPath(){
        if let from = graph.stationWithTag(fromStation), let to = graph.stationWithTag(toStation), let path = graph.shortestPath(source: from, destination: to){
            print(path.description)
            temporaryTag = 0
        }
    }
}

enum PictureName: String {
    case a = "A"
    case b = "B"
}

extension MainViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scheme
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScheme()
    }
}
