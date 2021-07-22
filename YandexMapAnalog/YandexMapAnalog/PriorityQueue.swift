import Foundation

struct PriorityQueue<T> {
    fileprivate var heap: Heap<T>
    
    init(sort: @escaping (T, T) -> Bool) {
        heap = Heap(priorityFunction: sort)
    }
    
   var isEmpty : Bool {
        return heap.isEmpty
    }
    
    var count : Int {
        return heap.count
    }
    
   func peek() -> T? {
        return heap.peek()
    }
    
    mutating func enqueue(_ element: T) {
        heap.enqueue(element)
    }
    
     mutating func dequeue() -> T? {
        return heap.dequeue()
    }
}

