
extension Group: File where Content: File {

    public init(@FileBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some File {
        content
    }
}
