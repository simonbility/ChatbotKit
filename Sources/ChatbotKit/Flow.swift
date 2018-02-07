import Foundation

public struct Flow<Exits> {
    public let builder: FlowBuilder
    public let entry: Node
    public let exits: Exits

    public func render() -> String {
        return builder.render()
    }
}

extension Flow {
    public func link<T>(exit: Node, to flow: Flow<T>) {
        let nodes = flow.builder.nodes
            .mapValues { Node(id: $0.id, type: $0.type, label: $0.label, flow: self.builder) }

        self.builder.nodes.merge(nodes) { _, new in new }
        self.builder.edges.merge(flow.builder.edges) { old, new in old.union(new) }
        self.builder.edges[exit.id, default: []].insert(flow.entry.id)
    }
}
