
public protocol LineModifier: TextModifier {
    func line(content: Line) -> Line
}

extension LineModifier {

    @TextBuilder
    public func text(content: Content) -> some Text {
        BuiltinText { environment in
            content
                .lines(environment: environment)
                .map(line(content:))
        }
    }
}
