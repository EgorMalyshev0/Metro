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
//        var tempor: Station?
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
//        for (index, element) in array.enumerated() {
//            if index == array.count - 1{
//                description += "\(element.name)"
//            } else if index == 0{
//                tempor = element
//            } else {
//                if element.edgeWith(destination: tempor!)!.isTransition{
//
//                } else {
//                    description += "\(tempor!.name) -> "
//                }
//            }
//        }
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
}
