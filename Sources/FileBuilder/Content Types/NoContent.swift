
public struct NoContent: Content {

    public init() {}

    public var body: some Content {
        BuiltinContent { _ in [] }
    }
}
