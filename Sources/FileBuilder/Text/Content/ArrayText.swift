
extension Array: Text where Element: Text {

    public var body: some Text {
        BuiltinText { environment in
            flatMap { $0.generate(environment: environment) }
        }
    }
}
