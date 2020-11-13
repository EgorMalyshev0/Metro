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
    
    init(name: String, tag: Int) {
        self.name = name
        self.tag = tag
    }
    
    func addEdge(destination: Station, time: TimeInterval) {
        self.edges.append(Edge(destination: destination, time: time))
        destination.edges.append(Edge(destination: self, time: time))
    }
}

class Edge {
    var destination: Station
    var time: TimeInterval
    
    init(destination: Station, time: TimeInterval) {
        self.destination = destination
        self.time = time
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
      return array
    }
    var description: String {
        var description = ""
        let array = self.array.reversed()
        for (index, element) in array.enumerated() {
            if index == array.count - 1{
                description += "\(element.name)"
            } else {
                description += "\(element.name) -> "
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
}
