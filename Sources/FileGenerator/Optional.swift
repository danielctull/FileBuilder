
extension Optional: Content where Wrapped: Content {

    public var body: some Content {
        Builtin { indentation in
            map { $0.generate(indentation: indentation) } ?? []
        }
    }
}
