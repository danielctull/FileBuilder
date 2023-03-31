
public protocol LinesModifier: TextModifier {
    func lines(content: [Line]) -> [Line]
}

extension LinesModifier {

    public func text(content: Content) -> some Text {
        BuiltinText { environment in
            let content = content.lines(environment: environment)
            return lines(content: content)
        }
    }
}
