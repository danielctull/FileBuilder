
public struct FileContent<C: Content> {
    private let indentation: Indentation
    private let _content: C
}

extension FileContent {

    public init(
        indentation: Indentation,
        @ContentBuilder build: () -> C
    ) {
        self.init(indentation: indentation, _content: build())
    }
}

extension FileContent {

    public var content: String {
        _content
            .generate(indentation: indentation)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}
