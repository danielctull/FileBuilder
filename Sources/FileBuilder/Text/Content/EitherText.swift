
extension Either: Text where First: Text, Second: Text {

    public var body: some Text {
        BuiltinText { values in
            switch value {
            case let .first(content): return try content.lines(environment: values)
            case let .second(content): return try content.lines(environment: values)
            }
        }
    }
}
