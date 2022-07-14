
extension Array: Content where Element: Content {

    public var body: some Content {
        Builtin { environment in
            flatMap { $0.generate(environment: environment) }
        }
    }
}
