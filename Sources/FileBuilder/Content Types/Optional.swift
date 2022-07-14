
extension Optional: Content where Wrapped: Content {

    public var body: some Content {
        Builtin { environment in
            map { $0.generate(environment: environment) } ?? []
        }
    }
}
