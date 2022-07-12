
struct AccumulatedContent<A: Content, B: Content> {
    let a: A
    let b: B
}

// MARK: - Content

extension AccumulatedContent: Content {
    var body: some Content { Builtin() }
}

// MARK: - Generator

extension AccumulatedContent: Generator {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {
        [
            a.generate(indentation: indentation, level: level),
            b.generate(indentation: indentation, level: level)
        ].joined(separator: "\n")
    }
}
