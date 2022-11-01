
extension ConditionalContent: Text {

    public var body: some Text {
        BuiltinContent(generate: generate)
    }
}
