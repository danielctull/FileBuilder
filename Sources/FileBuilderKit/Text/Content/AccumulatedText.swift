
extension Accumulated: Text where First: Text, Second: Text {

    public var text: some Text {
        BuiltinText { environment in
            let a = first.lines(environment: environment)
            let b = second.lines(environment: environment)
            return a + b
        }
    }
}
