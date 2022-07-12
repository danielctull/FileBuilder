
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

        Builtin { indentation in
            [
                header?.generate(indentation: indentation),
                content.indented().generate(indentation: indentation),
                footer?.generate(indentation: indentation)
            ]
            .compactMap { $0 }
            .flatMap { $0 }
        }
    }
}
