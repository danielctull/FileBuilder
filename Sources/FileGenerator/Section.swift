
public struct Section: Equatable {
    let header: Line?
    let content: [Content]
    let footer: Line?
}

extension Section {

    public init(
        header: Line? = nil,
        footer: Line? = nil,
        @ContentBuilder build: () -> [Content]
    ) {
        self.init(
            header: header,
            content: build(),
            footer: footer)
    }
}

// MARK: - Generate

extension Section {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {

        return content
            .map { content in
                content.generate(indentation: indentation, level: level.next)
            }
            .joined(separator: "\n")
    }
}
