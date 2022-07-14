
struct AccumulatedContent<First: Content, Second: Content> {
    let first: First
    let second: Second
}

// MARK: - Content

extension AccumulatedContent: Content {

    var body: some Content {

        Builtin { indentation in
            let a = first.generate(indentation: indentation)
            let b = second.generate(indentation: indentation)
            return a + b
        }
    }
}
