
public struct Section<C: Content> {
    let header: Line?
    let content: C
    let footer: Line?
}

extension Section {

    public init(
        header: Line? = nil,
        footer: Line? = nil,
        @ContentBuilder build: () -> C
    ) {
        self.init(
            header: header,
            content: build(),
            footer: footer)
    }
}

// MARK: - Content

extension Section: Content {

    public var body: some Content {

        Generator { indentation, level in
            let generated = [
                header?.generate(indentation: indentation, level: level),
                content.generate(indentation: indentation, level: level.next),
                footer?.generate(indentation: indentation, level: level)
            ]
            return generated
                .compactMap { $0 }
                .joined(separator: "\n")
        }
    }
}
