
extension String: Text {

    public var text: some Text {
        BuiltinText { _ in
            split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)
                .map(String.init)
                .map(Line.init)
        }
    }
}
