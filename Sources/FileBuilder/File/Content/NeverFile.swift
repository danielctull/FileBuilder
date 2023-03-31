
extension Never: File {
    public var file: Never { fatalError("Never file should not be called.") }
}
