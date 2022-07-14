
struct Builtin: Content {
    let _generate: (Indentation) -> [Line]
    var body: some Content { fatalError("Builtin body should not be called.") }
}

extension Never: Content {
    public var body: some Content { fatalError() }
}

extension Builtin {

    func generate(indentation: Indentation) -> [Line] {
        _generate(indentation)
    }
}
