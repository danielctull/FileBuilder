
struct BuiltinContent {

    private let _generate: (EnvironmentValues) -> [Line]

    init(generate: @escaping (EnvironmentValues) -> [Line]) {
        _generate = generate
    }

    func generate(environment: EnvironmentValues) -> [Line] {
        _generate(environment)
    }
}
