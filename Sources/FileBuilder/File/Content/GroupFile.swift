
extension Group: File where Content: File {

    public init(@FileBuilder content: () -> Content) {
        self.content = content()
    }

    public var file: some File {
        content
    }
}
