
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
