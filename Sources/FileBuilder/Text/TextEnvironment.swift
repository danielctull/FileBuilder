
extension Text {

    public func environment<Value>(
        _ keyPath: WritableKeyPath<EnvironmentValues, Value>,
        _ value: Value
    ) -> some Text {
        EnvironmentModifier(content: self) { $0[keyPath: keyPath] = value }
    }
}

extension EnvironmentModifier: Text where Content: Text {

    var body: some Text {
        BuiltinContent { environment in
            var environment = environment
            modify(&environment)
            return content.generate(environment: environment)
        }
    }
}
