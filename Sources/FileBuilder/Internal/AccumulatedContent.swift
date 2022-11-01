
public struct AccumulatedContent<First: Text, Second: Text> {
    let first: First
    let second: Second
}

// MARK: - Content

extension AccumulatedContent: Text {

    public var body: some Text {
        BuiltinContent { environment in
            let a = first.generate(environment: environment)
            let b = second.generate(environment: environment)
            return a + b
        }
    }
}
