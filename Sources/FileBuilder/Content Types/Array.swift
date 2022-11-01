
extension Array: TextContent where Element: TextContent {

    public var body: some TextContent {
        BuiltinContent { environment in
            flatMap { $0.generate(environment: environment) }
        }
    }
}
