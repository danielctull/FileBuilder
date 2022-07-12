
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
