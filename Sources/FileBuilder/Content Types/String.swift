
extension String: TextContent {

    public var body: some TextContent {
        BuiltinContent { _ in
            split(whereSeparator: \.isNewline)
                .map(String.init)
                .map(Line.init)
        }
    }
}
