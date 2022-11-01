
public struct EmptyText: Text {

    public init() {}

    public var body: some Text {
        BuiltinText { _ in [] }
    }
}
