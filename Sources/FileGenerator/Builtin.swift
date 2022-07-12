
struct Builtin: Content {
    let _generate: (Indentation, Indentation.Level) -> String
    var body: Never { fatalError("\(self) is builtin content, so this should not be called.") }
}

extension Never: Content {
    public var body: Never { fatalError() }
}

extension Builtin {

    func generate(indentation: Indentation, level: Indentation.Level) -> String {
        _generate(indentation, level)
    }
}
