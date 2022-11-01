
public struct Group<Content: TextContent>: TextContent {

    private let content: Content

    public init(@ContentBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some TextContent {
        content
    }
}
