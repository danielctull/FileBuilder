
public struct FileGenerator {

    public let indentation: Indentation

    public init(
        indentation: Indentation = .spaces(4)
    ) {
        self.indentation = indentation
    }
}
