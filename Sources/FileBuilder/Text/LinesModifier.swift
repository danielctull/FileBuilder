
public protocol LinesModifier: TextModifier {
    func lines(content: [Line]) -> [Line]
}

extension LinesModifier {

    @TextBuilder
    public func text(content: Content) -> some Text {
        BuiltinText { environment in
            let content = content.lines(environment: environment)
            return lines(content: content)
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
    func lines(content: [Line]) -> [Line] {
        lineModifier(content)
    }
}
