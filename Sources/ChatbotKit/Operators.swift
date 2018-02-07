import Foundation


infix operator <-: MultiplicationPrecedence

public func <- (lhs: Node, rhs: Node) -> Node {
    lhs.flow.edges[lhs.id, default: []].insert(rhs.id)

    return rhs
}

public func <- <R>(lhs: Node, rhs: (Node, R)) -> R {
    lhs.flow.edges[lhs.id, default: []].insert(rhs.0.id)

    return rhs.1
}
