
public struct NoContent: Content {
    public init() {}
    public var body: some Content {
        Builtin { _ in [] }
    }
}
