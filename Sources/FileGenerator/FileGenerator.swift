
public struct FileGenerator {
    public let indentation: Indentation
    public let contents: [Content]
    
    public init(
        indentation: Indentation = .spaces(4),
        contents: [Content]
    ) {
        self.indentation = indentation
        self.contents = contents
    }
}


extension FileGenerator {

    public init(
        indentation: Indentation,
        @ContentBuilder build: () -> [Content]
    ) {
        self.init(indentation: indentation, contents: build())
    }
}
