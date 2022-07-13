
extension Array: Content where Element: Content {

    public var body: some Content {
        Builtin { indentation in
            flatMap { $0.generate(indentation: indentation) }
        }
    }
}
