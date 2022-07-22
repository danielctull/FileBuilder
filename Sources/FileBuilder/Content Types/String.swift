
extension String: Content {

    public var body: some Content {
        BuiltinContent { _ in
            split(whereSeparator: \.isNewline)
                .map(String.init)
                .map(Line.init)
        }
    }
}
