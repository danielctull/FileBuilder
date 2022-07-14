
public struct File<C: Content>: Content {
    private let _content: C

    public var body: some Content {
        _content
    }
}

extension File {

    public init(@ContentBuilder content: () -> C) {
        self.init(_content: content())
    }
}
