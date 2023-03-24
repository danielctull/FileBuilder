
extension Accumulated: Text where First: Text, Second: Text {

    public var body: some Text {
        BuiltinText { environment in
            let a = try first.lines(environment: environment)
            let b = try second.lines(environment: environment)
            return a + b
        }
    }
}
