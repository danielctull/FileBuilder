
extension Optional: Text where Wrapped: Text {

    public var body: some Text {
        BuiltinContent { environment in
            map { $0.generate(environment: environment) } ?? []
        }
    }
}
