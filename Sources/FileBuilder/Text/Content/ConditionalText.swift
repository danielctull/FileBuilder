
extension ConditionalContent: Text where True: Text, False: Text {

    public var body: some Text {
        BuiltinContent { values in
            switch value {
            case let .true(content): return content.generate(environment: values)
            case let .false(content): return content.generate(environment: values)
            }
        }
    }
}
