
public struct File<C: Content> {
    public let indentation: Indentation
    public let content: C
}

extension File {

    public init(
        indentation: Indentation,
        @ContentBuilder build: () -> C
    ) {
        self.init(indentation: indentation, content: build())
    }
}

extension File {

    public func callAsFunction() -> String {
        content
            .generate(indentation: indentation)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}
