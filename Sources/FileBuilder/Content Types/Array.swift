
extension Array: Content where Element: Content {

    public var body: some Content {
        BuiltinContent { environment in
            flatMap { $0.generate(environment: environment) }
        }
    }
}
