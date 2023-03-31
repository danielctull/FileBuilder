
extension File {

    public func environment<Value>(
        _ keyPath: WritableKeyPath<EnvironmentValues, Value>,
        _ value: Value
    ) -> some File {
        EnvironmentModifier(content: self) { $0[keyPath: keyPath] = value }
    }
}

extension EnvironmentModifier: File where Content: File {

    var file: some File {
        BuiltinFile { directory, environment in
            var environment = environment
            modify(&environment)
            try content.write(in: directory, environment: environment)
        }
    }
}
