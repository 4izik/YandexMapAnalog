import Foundation
import UIKit

class AdjacencyList <T: Hashable>: Graph {
    
    private var adjancencies: [Vertex<T>: [Edge<T>]] = [:]
    
    init() {}
    
    func createVertex(data: T) -> Vertex<T> {
        
        let vertex = Vertex(data: data, index: adjancencies.count)
        adjancencies[vertex] = []
        return vertex
        
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Int) {
        
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjancencies[source]?.append(edge)
        
    }
    
    
    func addUndirectedEdge(between source: Vertex<T>, and destination: Vertex<T>, weight: Int) {
        
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
        
    }
    
    func add(_ edge: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Int) {
        
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
        
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjancencies[source] ?? []
    }
    
}

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (vertex, edges) in adjancencies { // 1
            var edgeString = ""
            for (index, edge) in edges.enumerated() { // 2
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), weight: \(edge.weight)")
                } else {
                    edgeString.append("\(edge.destination), weight: \(edge.weight)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
        }
        return result
    }
    
}
