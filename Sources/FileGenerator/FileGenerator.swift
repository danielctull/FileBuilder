
public struct FileGenerator {
    public let indentation: Indentation
    public let contents: [Content]
}


extension FileGenerator {

    public init(
        indentation: Indentation,
        @ContentBuilder build: () -> [Content]
    ) {
        self.init(indentation: indentation, contents: build())
    }
}

extension FileGenerator {

    public func callAsFunction() -> String {
        contents
            .map { $0.generate(indentation: indentation, level: .zero) }
            .joined(separator: "\n")
    }
}
