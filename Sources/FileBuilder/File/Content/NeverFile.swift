
extension Never: File {

    public var file: some File {
        fatalError("Never file should not be called.")
    }
}
