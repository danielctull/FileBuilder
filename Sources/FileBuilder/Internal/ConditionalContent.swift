
public struct ConditionalContent<True: Content, False: Content> {

    private let generate: (EnvironmentValues) -> [Line]

    init(_ content: True) {
        generate = content.generate
    }

    init(_ content: False) {
        generate = content.generate
    }
}

// MARK: - Content

extension ConditionalContent: Content {

    public var body: some Content {
        BuiltinContent(generate: generate)
    }
}
