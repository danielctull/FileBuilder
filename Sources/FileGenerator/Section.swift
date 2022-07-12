
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

    @ContentBuilder
    public var body: some Content {
        header
        content.indented()
        footer
    }
}
