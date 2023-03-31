
extension Never: Text {
    public var text: Never { fatalError("Never text should not be called.") }
}
