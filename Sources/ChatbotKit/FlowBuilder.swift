import Foundation

public class FlowBuilder {

    private static var typeToCount: [NodeType: Int] = [:]

    func generateId(_ type: NodeType) -> String {
        let count = FlowBuilder.typeToCount[type, default: 1]

        FlowBuilder.typeToCount[type] = count + 1

        return "\(self.id)_\(type.rawValue)_\(count)"
    }


    public let id: String
    public let name: String
    var nodes: [String: Node] = [:]
    var edges: [String: Set<String>] = [:]

    private init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    public func render() -> String {

        func indented(_ val: [String]) -> String {
            return val.map { "  \($0)" }.joined(separator: "\n")
        }

        func renderNodes() -> [String] {
            return self.nodes.values
                .sorted { $0.id < $1.id }
                .map { $0.declaration }
        }

        func renderEdges() -> [String] {
            return self.edges
                .sorted(by: { $0.key < $1.key })
                .flatMap { from, to in
                    to.map { "\(from) -> \($0)" }
            }
        }

        return """
        digraph G {
        \(indented(renderNodes()))

        \(indented(renderEdges()))
        }
        """
    }

    public static func create<T>(id: String, name: String, build: (FlowBuilder, Node) -> T) -> Flow<T> {
        let builder = FlowBuilder(id: id, name: name)
        let initial = builder.createNode(type: .entry, label: name, build: { $0 })

        let exit = build(builder, initial)
        return Flow(builder: builder, entry: initial, exits: exit)
    }

    @discardableResult
    public func createNode<T>(id: String? = nil, type: NodeType, label: String, build: (Node) -> T ) -> T {
        let id = id.map { "\(type.rawValue)_\($0)" } ?? generateId(type)

        let node = Node(id: id, type: type, label: label, flow: self)
        self.nodes[id] = node

        return build(node)
    }

    @discardableResult
    public func choice<T>(id: String? = nil, _ label: String, build: (Node) -> T) -> (Node, T) {
        let node = self.createNode(id: id, type: .choice, label: label, build: { $0 })

        return (node, build(node))
    }

    @discardableResult
    public func option(id: String? = nil, _ label: String, build: (Node) -> Node = { return $0 }) -> Node {
        return self.createNode(id: id, type: .option, label: label, build: build)
    }

    @discardableResult
    public func message(id: String? = nil, _ label: String, build: (Node) -> Node = { return $0 }) -> Node {
        return self.createNode(id: id, type: .message, label: label, build: build)
    }

    @discardableResult
    public func exit(id: String? = nil, _ label: String = "") -> Node {
        return self.createNode(id: id, type: .exit, label: label, build: { $0 })
    }

}





