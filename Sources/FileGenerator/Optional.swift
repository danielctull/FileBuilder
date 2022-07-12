
extension Optional: Content where Wrapped: Content {

    public var body: some Content {
        Builtin { indentation in
            switch self {
            case .none: return []
            case .some(let content): return content.generate(indentation: indentation)
            }
        }
    }
}
