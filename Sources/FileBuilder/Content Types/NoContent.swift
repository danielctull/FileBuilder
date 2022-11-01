
public struct NoContent: Text {

    public init() {}

    public var body: some Text {
        BuiltinContent { _ in [] }
    }
}
