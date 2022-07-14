
public struct Section<Header: Content, Footer: Content, C: Content> {
    let header: Header
    let content: C
    let footer: Footer
}

extension Section {

    public init(
        header: Header,
        footer: Footer,
        @ContentBuilder build: () -> C
    ) {
        self.init(
            header: header,
            content: build(),
            footer: footer)
    }
}

extension Section where Footer == NoContent {

    public init(
        header: Header,
        @ContentBuilder build: () -> C
    ) {
        self.init(
            header: header,
            content: build(),
            footer: NoContent())
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
