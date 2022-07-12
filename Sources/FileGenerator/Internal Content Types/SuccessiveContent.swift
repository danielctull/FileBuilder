
struct SuccessiveContent<First: Content, Second: Content> {
    let first: First
    let second: Second
}

// MARK: - Content

extension SuccessiveContent: Content {

    var body: some Content {

        Builtin { indentation, level in
            [
                first.generate(indentation: indentation, level: level),
                second.generate(indentation: indentation, level: level)
            ].joined(separator: "\n")
        }
    }
}
