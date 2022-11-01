
public struct AnyContent: TextContent {

    let generate: (EnvironmentValues) -> [Line]

    public init<C: TextContent>(_ content: C) {
        generate = content.generate
    }

    public var body: some TextContent {
        BuiltinContent(generate: generate)
    }
}
