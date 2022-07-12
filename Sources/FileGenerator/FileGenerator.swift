
public struct FileGenerator {
    public let indentation: Indentation
    public let lines: [Line]
    
    public init(
        indentation: Indentation = .spaces(4),
        lines: [Line]
    ) {
        self.indentation = indentation
        self.lines = lines
    }
}

// MARK: - Builder

extension FileGenerator {

    public init(indentation: Indentation, @Builder build: () -> [Line]) {
        self.init(indentation: indentation, lines: build())
    }

    @resultBuilder
    public enum Builder {

        public static func buildPartialBlock(first: Line) -> [Line] {
            [first]
        }

        public static func buildPartialBlock(accumulated: [Line], next: Line) -> [Line] {
            accumulated + [next]
        }

        public static func buildFinalResult(_ component: [Line]) -> [Line] {
            component
        }
    }
}
