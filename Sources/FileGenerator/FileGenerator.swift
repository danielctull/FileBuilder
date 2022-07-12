
public struct FileGenerator {

    public let indentation: Indentation
    public let lines: [Line]

    public init(
        indentation: Indentation = .spaces(4),
        lines: Line...
    ) {
        self.indentation = indentation
        self.lines = lines
    }
}
