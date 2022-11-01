
public struct EmptyText: Text {

    public init() {}

    public var body: some Text {
        BuiltinContent { _ in [] }
    }
}
