
public protocol LineModifier: ContentModifier where C: TextContent {
    func modifyLines(_ lines: [Line]) -> [Line]
}

extension LineModifier {

    @ContentBuilder
    public func body(content: C) -> some TextContent {
        BuiltinContent { environment in
            modifyLines(
                content.generate(environment: environment)
            )
        }
    }
}

extension TextContent {

    public func modifier(_ lineModifier: @escaping ([Line]) -> [Line]) -> some TextContent {
        modifier(AnyLineModifier(lineModifier: lineModifier))
    }

    public func modifier(_ lineModifier: @escaping (Line) -> Line) -> some TextContent {
        modifier(AnyLineModifier { $0.map(lineModifier) })
    }
}

private struct AnyLineModifier<C: TextContent>: LineModifier {
    let lineModifier: ([Line]) -> [Line]
    func modifyLines(_ lines: [Line]) -> [Line] {
        lineModifier(lines)
    }
}
