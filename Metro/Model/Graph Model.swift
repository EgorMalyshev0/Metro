//
//  Graph Model.swift
//  Metro
//
//  Created by Egor Malyshev on 28.10.2020.
//

import Foundation

class Station {
    var name: String
    var visited = false
    var tag: Int
    var edges: [Edge] = []
    var lineNumber: Int
    
    init(name: String, tag: Int, line: Int) {
        self.name = name
        self.tag = tag
        self.lineNumber = line
    }
    
    func addEdge(destination: Station, time: TimeInterval, tag: Int) {
        self.edges.append(Edge(destination: destination, time: time, tag: tag))
        destination.edges.append(Edge(destination: self, time: time, tag: tag))
    }
    
    func addTransition(destination: Station, time: TimeInterval) {
        self.edges.append(Edge(destination: destination, time: time, tag: 0, isTransition: true))
        destination.edges.append(Edge(destination: self, time: time, tag: 0, isTransition: true))
    }
    
    func edgeWith(destination: Station) -> Edge?{
        var foundedEdge: Edge? = nil
        for e in edges{
            if e.destination.name == destination.name { foundedEdge = e }
        }
        return foundedEdge
    }
}

class Edge {
    var destination: Station
    var time: TimeInterval
    var tag: Int
    var isTransition: Bool = false
    
    init(destination: Station, time: TimeInterval, tag: Int, isTransition: Bool = false) {
        self.destination = destination
        self.time = time
        self.isTransition = isTransition
        self.tag = tag
    }
}

class Graph {
    var stations: [Station]
    
    init(stations: [Station]) {
        self.stations = stations
    }
    
    func stationWithTag(_ tag: Int) -> Station? {
        var foundedStation: Station? = nil
        for s in stations{
            if s.tag == tag { foundedStation = s }
        }
        return foundedStation
    }
    
    func shortestPath(source: Station, destination: Station) -> Path? {
      var frontier: [Path] = [] {
        didSet { frontier.sort { return $0.cumulativeTime < $1.cumulativeTime } }
      }
        var transitions: [Edge] = []
      
      frontier.append(Path(station: source))
      
      while !frontier.isEmpty {
        let fastestPath = frontier.removeFirst()
        guard !fastestPath.station.visited else { continue }
        
        if fastestPath.station === destination {
          return fastestPath
        }
        
        fastestPath.station.visited = true
        
        for edge in fastestPath.station.edges where !edge.destination.visited {
          frontier.append(Path(station: edge.destination, edge: edge, previousPath: fastestPath))
            if edge.isTransition{
                transitions.append(edge)
            }
        }
      }
      return nil
    }
    
}

class Path: CustomStringConvertible {
    public let cumulativeTime: Double
    public let station: Station
    public let previousPath: Path?
    var array: [Station] {
      var array: [Station] = [self.station]
      var iterativePath = self
      while let path = iterativePath.previousPath {
        array.append(path.station)
        iterativePath = path
        }
        return array.reversed()
    }
    var description: String {
        var description = ""
        for i in 0...array.count - 1 {
            if i == array.count - 1{
                description += "\(array[i].name)"
            } else {
                if array[i].edgeWith(destination: array[i+1])!.isTransition{
                    description += "\(array[i].name) -> [Переход на линию \(array[i+1].lineNumber)] -> "
                } else {
                    description += "\(array[i].name) -> "
                }
            }
        }
        if cumulativeTime < 60 {
            let time = "\nВремя в пути: \(cumulativeTime) мин"
            description += time
        } else{
            let time = "\nВремя в пути: 1 ч \(cumulativeTime - 60) мин"
            description += time
        }
        return description
    }
  
  init(station: Station, edge: Edge? = nil, previousPath: Path? = nil) {
    if
      let previousPath = previousPath,
      let edge = edge {
      self.cumulativeTime = edge.time + previousPath.cumulativeTime
    } else {
      self.cumulativeTime = 0
    }
    self.station = station
    self.previousPath = previousPath
  }
    
    func transitionsCount() -> String {
        var count = 0
        for i in 0...array.count - 2{
            if array[i].edgeWith(destination: array[i+1])!.isTransition{
                count += 1
            }
        }
        switch count {
        case 0:
            return "без пересадок"
        case 1:
            return "1 пересадка"
        default:
            return "\(count) пересадки"
        }
    }
    
    func detailsInfo() -> String {
        var info = ""
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let futureDate = Calendar.current.date(byAdding: .minute, value: Int(cumulativeTime.rounded()), to: date)
        info += formatter.string(from: date) + " - " + formatter.string(from: futureDate!) + ", " +  transitionsCount()
        return info
    }
}
