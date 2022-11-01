
extension Optional: TextContent where Wrapped: TextContent {

    public var body: some TextContent {
        BuiltinContent { environment in
            map { $0.generate(environment: environment) } ?? []
        }
    }
}
