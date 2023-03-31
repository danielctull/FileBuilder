
public protocol LineModifier: TextModifier {
    func modifyLine(_ line: Line) -> Line
}

extension LineModifier {

    @TextBuilder
    public func text(content: Content) -> some Text {
        BuiltinText { environment in
            content
                .lines(environment: environment)
                .map(modifyLine)
        }
    }
}
