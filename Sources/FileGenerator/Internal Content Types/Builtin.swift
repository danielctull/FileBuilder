
struct Builtin: Content {
    let _generate: (Indentation) -> [Line]
    var body: Never { fatalError("\(self) is builtin content, so this should not be called.") }
}

extension Never: Content {
    public var body: Never { fatalError() }
}

extension Builtin {

    func generate(indentation: Indentation) -> [Line] {
        _generate(indentation)
    }
}
