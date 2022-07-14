
public struct AccumulatedContent<First: Content, Second: Content> {
    let first: First
    let second: Second
}

// MARK: - Content

extension AccumulatedContent: Content {

    public var body: some Content {
        Builtin { environment in
            let a = first.generate(environment: environment)
            let b = second.generate(environment: environment)
            return a + b
        }
    }
}
