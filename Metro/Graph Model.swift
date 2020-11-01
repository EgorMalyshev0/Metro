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

class GraphCreator {
    func create() -> Graph {
        var stations: [Station] = []
        let one = Station(name: "1", tag: 1)
        let two = Station(name: "2", tag: 2)
        let three = Station(name: "3", tag: 3)
        one.addEdge(destination: two, time: 10)
        two.addEdge(destination: three, time: 6)
        stations.append(one)
        stations.append(two)
        stations.append(three)
        return Graph(stations: stations)
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
