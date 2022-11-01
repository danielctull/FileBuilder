
struct BuiltinText {

    private let _generate: (EnvironmentValues) -> [Line]

    init(generate: @escaping (EnvironmentValues) -> [Line]) {
        _generate = generate
    }

    func generate(environment: EnvironmentValues) -> [Line] {
        _generate(environment)
    }
}

extension BuiltinText: Text {

    var body: Never { fatalError("Builtin body should not be called.") }
}
