
public struct File<C: Content>: Content {

    private let content: C

    public init(@ContentBuilder content: () -> C) {
        self.content = content()
    }

    public var body: some Content {
        content
    }
}
