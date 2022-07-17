
public struct AnyContent: Content {

    let generate: (EnvironmentValues) -> [Line]

    public init<C: Content>(_ content: C) {
        generate = content.generate
    }

    public var body: some Content {
        BuiltinContent(generate: generate)
    }
}
