
public protocol LinesModifier: TextModifier {
    func modifyLines(_ lines: [Line]) -> [Line]
}

extension LinesModifier {

    @TextBuilder
    public func text(content: Content) -> some Text {
        BuiltinText { environment in
            modifyLines(
                content.lines(environment: environment)
            )
        }
    }
}

extension Text {

    public func modifier(_ lineModifier: @escaping ([Line]) -> [Line]) -> some Text {
        modifier(AnyLinesModifier(lineModifier: lineModifier))
    }

    public func modifier(_ lineModifier: @escaping (Line) -> Line) -> some Text {
        modifier(AnyLinesModifier { $0.map(lineModifier) })
    }
}

private struct AnyLinesModifier: LinesModifier {
    let lineModifier: ([Line]) -> [Line]
    func modifyLines(_ lines: [Line]) -> [Line] {
        lineModifier(lines)
    }
}
