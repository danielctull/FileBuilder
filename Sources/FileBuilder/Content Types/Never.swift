
extension Never: Text {
    public var body: Never { fatalError("Never body should not be called.") }
}
