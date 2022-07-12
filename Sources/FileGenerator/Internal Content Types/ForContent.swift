
struct ForContent<Element: Content> {
    let content: [Element]
}

// MARK: - Content

extension ForContent: Content {

    var body: some Content {

        Builtin { indentation, level in
            content
                .map { $0.generate(indentation: indentation, level: level) }
                .joined(separator: "\n")
        }
    }
}
