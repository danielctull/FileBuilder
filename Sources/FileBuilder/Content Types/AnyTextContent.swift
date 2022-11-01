
public struct AnyTextContent: Text {

    let generate: (EnvironmentValues) -> [Line]

    public init<Content: Text>(_ content: Content) {
        generate = content.generate
    }

    public var body: some Text {
        BuiltinContent(generate: generate)
    }
}
