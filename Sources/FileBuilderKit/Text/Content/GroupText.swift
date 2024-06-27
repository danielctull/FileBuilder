
extension Group: Text where Content: Text {

    public init(@TextBuilder content: () -> Content) {
        self.content = content()
    }

    public var text: some Text {
        content
    }
}
