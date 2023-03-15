
public struct AnyText: Text {

    let lines: (EnvironmentValues) -> [Line]

    public init<Content: Text>(_ content: Content) {
        lines = content.lines
    }

    public var body: some Text {
        BuiltinText(lines: lines)
    }
}
