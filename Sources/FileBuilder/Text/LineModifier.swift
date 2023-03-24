
public protocol LineModifier: TextModifier {
    func modifyLines(_ lines: [Line]) throws -> [Line]
}

extension LineModifier {

    @TextBuilder
    public func body(content: Content) -> some Text {
        BuiltinText { environment in
            try modifyLines(
                content.lines(environment: environment)
            )
        }
    }
}

extension Text {

    public func modifier(_ lineModifier: @escaping ([Line]) throws -> [Line]) -> some Text {
        modifier(AnyLineModifier(lineModifier: lineModifier))
    }

    public func modifier(_ lineModifier: @escaping (Line) throws -> Line) -> some Text {
        modifier(AnyLineModifier { try $0.map(lineModifier) })
    }
}

private struct AnyLineModifier: LineModifier {
    let lineModifier: ([Line]) throws -> [Line]
    func modifyLines(_ lines: [Line]) throws -> [Line] {
        try lineModifier(lines)
    }
}
