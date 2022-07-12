
struct SuccessiveContent<First: Content, Second: Content> {
    let first: First
    let second: Second
}

// MARK: - Content

extension SuccessiveContent: Content {

    var body: some Content {

        Builtin { indentation in
            [
                first.generate(indentation: indentation),
                second.generate(indentation: indentation)
            ].flatMap { $0 }
        }
    }
}
