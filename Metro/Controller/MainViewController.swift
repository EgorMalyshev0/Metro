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
    lazy var scheme = MetroScheme()
    lazy var choosingView = StationChoosingView()
    var imgViews = [UIImageView]()
    var path: Path?
        
    var temporaryTag: Int = 0
    var fromStation: Int = 0 {
        didSet {
            guard fromStation != 0 else {
                picturesReboot()
                cleanPath()
                return
            }
            if fromStation != toStation {
                picturesReboot()
            } else {
                toStation = 0
                picturesReboot()
            }
            if toStation != 0 {
                getPath()
            }
        }
    }
    var toStation: Int = 0{
        didSet {
            guard toStation != 0 else {
                picturesReboot()
                cleanPath()
                return
            }
            if toStation != fromStation {
                picturesReboot()
            } else {
                fromStation = 0
                picturesReboot()
            }
            if fromStation != 0 {
                getPath()
            }
        }
    }
    
    lazy var zoomTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        tap.numberOfTapsRequired = 2
        return tap
    }()
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pathDetailsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateDetailsView()
        configurateScheme()
        countMinScale()
        centerScheme()
        stationChoosingViewAdding()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        centerScheme()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PathDetailsViewController, segue.identifier == "showDetails" {
            vc.path = path
        }
    }
    
    @IBAction func resetPath(_ sender: Any) {
        fromStation = 0
        toStation = 0
        picturesReboot()
        cleanPath()
        UIView.animate(withDuration: 0.2) {
            self.detailsView.transform = CGAffineTransform.identity
        }
    }
    
    func configurateScheme() {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        self.scroll = scroll
        view.addSubview(scroll)
        view.insertSubview(scroll, belowSubview: detailsView)
        let scheme = UIView.fromNIB() as MetroScheme
        self.scheme = scheme
        scroll.addSubview(scheme)
        scroll.contentSize = scheme.bounds.size
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
        let stations = scheme.subviews.filter{$0 is StationButton}
        for s in stations{
            if let s = s as? StationButton {
                s.addTarget(self, action: #selector(showStationChoosingView), for: .touchUpInside)
                s.addAction(UIAction(handler: { (action) in
                    if let stationButton = action.sender as? StationButton{
                        self.temporaryTag = stationButton.tag
                        let station = self.graph.stationWithTag(stationButton.tag)
                        self.choosingView.station = station
                    }
                }), for: .touchUpInside)
            }
        }
        
        scheme.addGestureRecognizer(zoomTap)
        scheme.isUserInteractionEnabled = true
    }
    
    func countMinScale(){
        let bounds = self.view.bounds.size
        let schemeBounds = scheme.bounds.size
        let xscale = bounds.width / schemeBounds.width
        let yscale = bounds.height / schemeBounds.height
        let minScale = min(xscale, yscale)
        scroll.minimumZoomScale = minScale
        scroll.maximumZoomScale = 1
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
    
    @objc func handleZoomingTap(sender: UITapGestureRecognizer){
        let location = sender.location(in: sender.view)
    
        let currentScale = scroll.zoomScale
        let minScale = scroll.minimumZoomScale
        let maxScale = scroll.maximumZoomScale
        
        if minScale == maxScale && minScale > 1 { return }
        let toScale = maxScale
        let finalScale = (currentScale < maxScale) ? toScale : minScale
        
        let width = scroll.bounds.width / finalScale
        let height = scroll.bounds.height / finalScale
        let x = location.x - width / 2
        let y = location.y - height / 2
        let zoomRect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
        scroll.zoom(to: zoomRect, animated: true)
    }
    
    func stationChoosingViewAdding(){
        let view = UIView.fromNIB() as StationChoosingView
        let size = CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 5)
        view.frame = CGRect(x: 0, y: self.view.bounds.height, width: size.width, height: size.height)
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        self.view.addSubview(view)
        choosingView = view
        choosingView.fromStationButton.addAction(UIAction(handler: { (action) in
            if self.temporaryTag != 0{
                self.fromStation = self.temporaryTag
                self.temporaryTag = 0
            }
            self.choosingView.close(UIButton.self)
        }), for: .touchUpInside)
        choosingView.toStationButton.addAction(UIAction(handler: { (action) in
            if self.temporaryTag != 0{
                self.toStation = self.temporaryTag
                self.temporaryTag = 0
            }
            self.choosingView.close(UIButton.self)
        }), for: .touchUpInside)
    }
    
    @objc
    func showStationChoosingView(){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            let x = self.choosingView.frame.origin.x
            self.choosingView.transform = CGAffineTransform(translationX: x, y: -self.choosingView.frame.size.height)
        }, completion: nil)
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
            let size = CGSize(width: 35, height: 42)
            if button.semanticContentAttribute == .forceRightToLeft {
                let origin = CGPoint(x: fr.origin.x + center.x - size.width / 2, y: fr.origin.y - size.height + center.y)
                let img = UIImageView(frame: CGRect(origin: origin, size: size))
                img.image = UIImage(named: pictureName.rawValue)
                img.tag = check
                scheme.addSubview(img)
                imgViews.append(img)
            } else {
                let origin = CGPoint(x: fr.origin.x + center.x - size.width / 2, y: fr.origin.y - size.height + center.y)
                let img = UIImageView(frame: CGRect(origin: origin, size: size))
                img.image = UIImage(named: pictureName.rawValue)
                img.tag = check
                scheme.addSubview(img)
                imgViews.append(img)
            }
        imgViews.forEach{img in
            img.transform = CGAffineTransform(scaleX: 1.0 / scroll.zoomScale, y: 1.0 / scroll.zoomScale)
            setPosition(img)
        }
    }
    
    func setPosition(_ img: UIImageView){
        if img.tag == fromStation || img.tag == toStation {
            guard let button = scheme.subviews.filter({$0.tag == img.tag}).first as? StationButton else {return}
            let fr = button.frame
            let center = button.imageView!.center
            let origin = CGPoint(x: fr.origin.x + center.x - img.frame.width / 2, y: fr.origin.y - img.frame.height + center.y)
            img.frame.origin = origin
        }
    }
    
    func picturesReboot(){
        imgViews.forEach {$0.removeFromSuperview()}
        imgViews.removeAll()
        showPicture(.a)
        showPicture(.b)
    }

    func getPath(){
        if let from = graph.stationWithTag(fromStation), let to = graph.stationWithTag(toStation), let path = graph.shortestPath(source: from, destination: to){
            cleanPath()
            print(path.description)
            let time = Int(path.cumulativeTime.rounded())
            timeLabel.text = "\(time) мин"
            pathDetailsLabel.text = path.detailsInfo()
            showPathOnScheme(path: path)
            temporaryTag = 0
            for s in graph.stations{
                s.visited = false
            }
            self.path = path
        }
    }
    
    func showPathOnScheme(path: Path){
        let stations = path.array
        var edges: [Edge] = []
        for i in 0...stations.count - 2 {
            edges.append(stations[i].edgeWith(destination: stations[i+1])!)
        }
        let stationsOnScheme = scheme.subviews.filter{$0 is StationButton}
        let edgesOnScheme = scheme.subviews.filter{$0 is EdgeView}
        for ss in stationsOnScheme {
            ss.alpha = 0.3
            for s in stations {
                if s.tag == ss.tag{
                    ss.alpha = 1
                }
            }
        }
        for ee in edgesOnScheme {
            ee.alpha = 0.3
            for e in edges {
                if e.tag == ee.tag{
                    ee.alpha = 1
                }
            }
        }
        scheme.checkHiddenEdges(edges: edges)
        showDetailsWindow()
    }
    
    func cleanPath(){
        let stationsOnScheme = scheme.subviews.filter{$0 is StationButton}
        let edgesOnScheme = scheme.subviews.filter{$0 is EdgeView}
        for ss in stationsOnScheme {
            ss.alpha = 1
        }
        for ee in edgesOnScheme {
            ee.alpha = 1
        }
        scheme.rebootHiddenEdges()
    }
    
    func configurateDetailsView(){
        detailsView.layer.cornerRadius = 10
        detailsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        detailsView.layer.shadowOffset = .zero
        detailsView.layer.shadowColor = UIColor.gray.cgColor
        detailsView.layer.shadowRadius = 4
        detailsView.layer.shadowOpacity = 0.5
    }
    
    func showDetailsWindow(){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            let x = self.detailsView.frame.origin.x
            self.detailsView.transform = CGAffineTransform(translationX: x, y: -self.detailsView.frame.size.height)
        }, completion: nil)
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
        imgViews.forEach{img in
            img.transform = CGAffineTransform(scaleX: 1.0 / scroll.zoomScale, y: 1.0 / scroll.zoomScale)
            setPosition(img)
        }
        centerScheme()
    }
}

extension MainViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
