
extension String: Text {

    public var body: some Text {
        BuiltinText { _ in
            split(whereSeparator: \.isNewline)
                .map(String.init)
                .map(Line.init)
        }
    }
}
