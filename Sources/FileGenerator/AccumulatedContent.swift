
struct AccumulatedContent<A: Content, B: Content> {
    let a: A
    let b: B
}

// MARK: - Content

extension AccumulatedContent: Content {

    var body: some Content {

        Generator { indentation, level in
            [
                a.generate(indentation: indentation, level: level),
                b.generate(indentation: indentation, level: level)
            ].joined(separator: "\n")
        }
    }
}
