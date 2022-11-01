
public struct AnyText: Text {

    let generate: (EnvironmentValues) -> [Line]

    public init<Content: Text>(_ content: Content) {
        generate = content.generate
    }

    public var body: some Text {
        BuiltinText(generate: generate)
    }
}
