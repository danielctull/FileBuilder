
struct Builtin: Content {
    let _generate: (Indentation) -> [Line]
    var body: Never { fatalError("Builtin body should not be called.") }
}

extension Builtin {

    func generate(indentation: Indentation) -> [Line] {
        _generate(indentation)
    }
}
