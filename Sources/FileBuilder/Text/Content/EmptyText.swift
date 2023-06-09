
extension Empty: Text {

    public var text: some Text {
        BuiltinText { _ in [] }
    }
}
