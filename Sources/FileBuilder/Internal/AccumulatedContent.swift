
public struct AccumulatedContent<First: TextContent, Second: TextContent> {
    let first: First
    let second: Second
}

// MARK: - Content

extension AccumulatedContent: TextContent {

    public var body: some TextContent {
        BuiltinContent { environment in
            let a = first.generate(environment: environment)
            let b = second.generate(environment: environment)
            return a + b
        }
    }
}
