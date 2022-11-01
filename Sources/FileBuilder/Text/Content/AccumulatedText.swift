
extension AccumulatedContent: Text where First: Text, Second: Text {

    public var body: some Text {
        BuiltinContent { environment in
            let a = first.generate(environment: environment)
            let b = second.generate(environment: environment)
            return a + b
        }
    }
}
