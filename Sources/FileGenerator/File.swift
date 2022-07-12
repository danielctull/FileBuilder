
public struct File<C: Content> {
    private let indentation: Indentation
    private let _content: C
}

extension File {

    public init(
        indentation: Indentation,
        @ContentBuilder build: () -> C
    ) {
        self.init(indentation: indentation, _content: build())
    }
}

extension File {

    public var content: String {
        _content
            .generate(indentation: indentation)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}
