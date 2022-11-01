
public struct NoContent: TextContent {

    public init() {}

    public var body: some TextContent {
        BuiltinContent { _ in [] }
    }
}
