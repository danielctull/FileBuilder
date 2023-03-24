
public struct AnyText: Text {

    let lines: (EnvironmentValues) throws -> [Line]

    public init<Content: Text>(_ content: Content) {
        lines = content.lines
    }

    public var body: some Text {
        BuiltinText(lines: lines)
    }
}
