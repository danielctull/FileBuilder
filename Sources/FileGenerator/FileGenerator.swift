
public struct FileGenerator<C: Content> {
    public let indentation: Indentation
    public let content: C
}

extension FileGenerator {

    public init(
        indentation: Indentation,
        @ContentBuilder build: () -> C
    ) {
        self.init(indentation: indentation, content: build())
    }
}

extension FileGenerator {

    public func callAsFunction() -> String {
        content
            .generate(indentation: indentation)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}
