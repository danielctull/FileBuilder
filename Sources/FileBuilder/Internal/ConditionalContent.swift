
public struct ConditionalContent<True: Text, False: Text> {

    private let generate: (EnvironmentValues) -> [Line]

    init(_ content: True) {
        generate = content.generate
    }

    init(_ content: False) {
        generate = content.generate
    }
}

// MARK: - Content

extension ConditionalContent: Text {

    public var body: some Text {
        BuiltinContent(generate: generate)
    }
}
