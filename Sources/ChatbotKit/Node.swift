import Foundation

public struct Node {
    public let id: String
    public let type: NodeType
    public let label: String

    public unowned let flow: FlowBuilder

    public var declaration: String {
        return """
        \(self.id)[label="\(self.label)"];
        """
    }
}

public enum NodeType: String {
    case entry
    case choice
    case option
    case response
    case message
    case exit
}

