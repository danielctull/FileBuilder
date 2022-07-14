
struct Builtin: Content {
    let _generate: (EnvironmentValues) -> [Line]
    var body: Never { fatalError("Builtin body should not be called.") }
}

extension Builtin {

    func generate(environment: EnvironmentValues) -> [Line] {
        _generate(environment)
    }
}
