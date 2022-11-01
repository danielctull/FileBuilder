
public struct Group<C: TextContent>: TextContent {

    private let content: C

    public init(@ContentBuilder content: () -> C) {
        self.content = content()
    }

    public var body: some TextContent {
        content
    }
}
