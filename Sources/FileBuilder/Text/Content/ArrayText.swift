
extension Array: Text where Element: Text {

    public var text: some Text {
        BuiltinText { environment in
            flatMap { $0.lines(environment: environment) }
        }
    }
}
