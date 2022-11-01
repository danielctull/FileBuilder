
public struct Group<Content: TextContent>: TextContent {

    private let content: Content

    public init(@TextContentBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some TextContent {
        content
    }
}
