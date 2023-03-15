
struct BuiltinText {

    private let _lines: (EnvironmentValues) -> [Line]

    init(lines: @escaping (EnvironmentValues) -> [Line]) {
        _lines = lines
    }

    func lines(environment: EnvironmentValues) -> [Line] {
        _lines(environment)
    }
}

extension BuiltinText: Text {

    var body: Never { fatalError("Builtin body should not be called.") }
}
