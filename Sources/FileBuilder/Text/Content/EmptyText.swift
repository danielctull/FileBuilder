
public struct EmptyText: Text {

    public init() {}

    public var text: some Text {
        BuiltinText { _ in [] }
    }
}
