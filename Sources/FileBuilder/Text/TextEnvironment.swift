
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
        BuiltinText { environment in
            var environment = environment
            modify(&environment)
            return content.lines(environment: environment)
        }
    }
}
