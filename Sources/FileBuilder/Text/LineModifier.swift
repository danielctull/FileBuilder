
public protocol LineModifier: TextModifier where Content: Text {
    func modifyLines(_ lines: [Line]) -> [Line]
}

extension LineModifier {

    @TextBuilder
    public func body(content: Content) -> some Text {
        BuiltinContent { environment in
            modifyLines(
                content.generate(environment: environment)
            )
        }
    }
}

extension Text {

    public func modifier(_ lineModifier: @escaping ([Line]) -> [Line]) -> some Text {
        modifier(AnyLineModifier(lineModifier: lineModifier))
    }

    public func modifier(_ lineModifier: @escaping (Line) -> Line) -> some Text {
        modifier(AnyLineModifier { $0.map(lineModifier) })
    }
}

private struct AnyLineModifier<Content: Text>: LineModifier {
    let lineModifier: ([Line]) -> [Line]
    func modifyLines(_ lines: [Line]) -> [Line] {
        lineModifier(lines)
    }
}
