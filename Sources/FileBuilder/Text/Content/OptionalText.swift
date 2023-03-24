
extension Optional: Text where Wrapped: Text {

    public var body: some Text {
        BuiltinText { environment in
            try map { try $0.lines(environment: environment) } ?? []
        }
    }
}
