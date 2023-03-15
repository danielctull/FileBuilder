
extension Either: Text where First: Text, Second: Text {

    public var body: some Text {
        BuiltinText { values in
            switch value {
            case let .first(content): return content.lines(environment: values)
            case let .second(content): return content.lines(environment: values)
            }
        }
    }
}
