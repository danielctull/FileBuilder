
struct ForContent<Element: Content> {
    let content: [Element]
}

// MARK: - Content

extension ForContent: Content {

    var body: some Content {

        Builtin { indentation in
            content.flatMap { $0.generate(indentation: indentation) }
        }
    }
}
