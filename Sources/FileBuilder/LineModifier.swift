
public protocol LineModifier: ContentModifier where C: Content {
    func modifyLines(_ lines: [Line]) -> [Line]
}

extension LineModifier {

    @ContentBuilder
    public func body(content: C) -> some Content {
        BuiltinContent { environment in
            modifyLines(
                content.generate(environment: environment)
            )
        }
    }
}

extension Content {

    public func modifier(_ lineModifier: @escaping ([Line]) -> [Line]) -> some Content {
        modifier(AnyLineModifier(lineModifier: lineModifier))
    }

    public func modifier(_ lineModifier: @escaping (Line) -> Line) -> some Content {
        modifier(AnyLineModifier { $0.map(lineModifier) })
    }
}

private struct AnyLineModifier<C: Content>: LineModifier {
    let lineModifier: ([Line]) -> [Line]
    func modifyLines(_ lines: [Line]) -> [Line] {
        lineModifier(lines)
    }
}
