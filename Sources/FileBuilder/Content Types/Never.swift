
extension Never: TextContent {
    public var body: Never { fatalError("Never body should not be called.") }
}
