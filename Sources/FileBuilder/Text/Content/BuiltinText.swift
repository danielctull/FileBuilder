
struct BuiltinText {

    private let _lines: (EnvironmentValues) throws -> [Line]

    init(lines: @escaping (EnvironmentValues) throws -> [Line]) {
        _lines = lines
    }

    func lines(environment: EnvironmentValues) throws -> [Line] {
        try _lines(environment)
    }
}

extension BuiltinText: Text {

    var body: Never { fatalError("Builtin body should not be called.") }
}
