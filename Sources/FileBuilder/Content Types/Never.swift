
extension Never: Content {
    public var body: Never { fatalError("Never body should not be called.") }
}
