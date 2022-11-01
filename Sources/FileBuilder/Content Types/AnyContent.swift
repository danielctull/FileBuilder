
public struct AnyContent: TextContent {

    let generate: (EnvironmentValues) -> [Line]

    public init<Content: TextContent>(_ content: Content) {
        generate = content.generate
    }

    public var body: some TextContent {
        BuiltinContent(generate: generate)
    }
}
