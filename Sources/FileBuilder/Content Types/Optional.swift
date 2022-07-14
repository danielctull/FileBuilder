
extension Optional: Content where Wrapped: Content {

    public var body: some Content {
        BuiltinContent { environment in
            map { $0.generate(environment: environment) } ?? []
        }
    }
}
