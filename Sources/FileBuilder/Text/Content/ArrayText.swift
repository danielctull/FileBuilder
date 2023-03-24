
extension Array: Text where Element: Text {

    public var body: some Text {
        BuiltinText { environment in
            try flatMap { try $0.lines(environment: environment) }
        }
    }
}
