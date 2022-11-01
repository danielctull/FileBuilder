
extension String: Text {

    public var body: some Text {
        BuiltinContent { _ in
            split(whereSeparator: \.isNewline)
                .map(String.init)
                .map(Line.init)
        }
    }
}
