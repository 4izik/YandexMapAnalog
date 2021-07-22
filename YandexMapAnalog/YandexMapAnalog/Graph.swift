import UIKit



enum EdgeType {
    case directed
    case undirected
}

struct Vertex<T> {
    let data: T
    let index: Int
}

enum Visit<Element: Hashable> {
    case source
    case edge(Edge<Element>)
}

struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Int?
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}

extension Vertex: CustomStringConvertible {

    var description: String{
        return "\(index):\(data)"
    }

}

protocol Graph {
    
    associatedtype Element: Hashable
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>,  weight: Int)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Int)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Int)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    
}


extension Graph {
  func route(to destination: Vertex<Element>, in tree: [Vertex<Element> : Visit<Element>]) -> [Edge<Element>] { // 1

      var vertex = destination // 2
      var path : [Edge<Element>] = [] // 3

      while let visit = tree[vertex],
        case .edge(let edge) = visit { // 4

        path = [edge] + path
        vertex = edge.source // 5
      }
      return path // 6
    }
    
func distance(to destination: Vertex<Element>, in tree: [Vertex<Element> : Visit<Element>]) -> Int { // 1
      let path = route(to: destination, in: tree) // 2
      let distances = path.flatMap{ $0.weight } // 3
      return distances.reduce(0, { $0 + $1 }) // 4
    }
    
  func dijkstra(from source: Vertex<Element>, to destination: Vertex<Element>) -> [Edge<Element>]? {
    var visits : [Vertex<Element> : Visit<Element>] = [source: .source]
    var priorityQueue = PriorityQueue<Vertex<Element>>(sort: { self.distance(to: $0, in: visits) < self.distance(to: $1, in: visits) })
    priorityQueue.enqueue(source)
    while let visitedVertex = priorityQueue.dequeue() { // 1
      if visitedVertex == destination { // 2
        return route(to: destination, in: visits) // 3
      }
        let neighbourEdges = edges(from: visitedVertex) ?? [] // 1
        for edge in neighbourEdges { // 2
          if let weight = edge.weight { // 3
            if visits[edge.destination] != nil { // 1
              if distance(to: visitedVertex, in: visits) + weight < distance(to: edge.destination, in: visits) { // 2
                visits[edge.destination] = .edge(edge) // 3
                priorityQueue.enqueue(edge.destination) // 4
              }
            } else { // 1
              visits[edge.destination] = .edge(edge) // 3
              priorityQueue.enqueue(edge.destination) // 4
            }
          }
        }
    }
      return nil
    }
}

