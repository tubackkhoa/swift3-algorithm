import Foundation

public struct Stack<T> {
    private var array = [T]()

    public init() {
        array = []
    }

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func push(_ element: T) {
        array.append(element)
    }

    public mutating func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }

    public func peek() -> T? {
        return array.last
    }
}

#if swift(>=3.0)
// remove type, change Generator to Iterator, generate method to makeIterator
extension Stack: Sequence {
  public func makeIterator() -> AnyIterator<T> {
    var curr = self
    return AnyIterator {
      _ -> T? in
      return curr.pop()
    }
  }
  
  // support swift 2
  public func generate() -> AnyIterator<T> {
    return makeIterator()
  }
}
#else
extension Stack: SequenceType {
    public func generate() -> AnyGenerator<T> {
        var curr = self
        return anyGenerator {
            _ -> T? in
            return curr.pop()
        }
    }
}
#endif
