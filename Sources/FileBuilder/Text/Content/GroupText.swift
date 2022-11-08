
extension Group: Text where Content: Text {

    public init(@TextBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some Text {
        content
    }
}
