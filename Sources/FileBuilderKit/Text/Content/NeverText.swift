
extension Never: Text {

    public var text: some Text {
        fatalError("Never text should not be called.")
    }
}
