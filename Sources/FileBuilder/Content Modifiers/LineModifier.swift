
protocol LineModifier: ContentModifier where C: Content {
    var modify: (Line) -> Line { get }
}

extension LineModifier {

    func body(content: C) -> some Content {
        BuiltinContent { environment in
            content
                .generate(environment: environment)
                .map(modify)
        }
    }
}

protocol LinesModifier: ContentModifier where C: Content {
    var modifier: ([Line]) -> [Line] { get }
}

struct AnyLinesModifier<C: Content>: LinesModifier {
    let modifier: ([Line]) -> [Line]
}

extension LinesModifier {

    func body(content: C) -> some Content {
        BuiltinContent { environment in
            let lines = content.generate(environment: environment)
            return modifier(lines)
        }
    }
}

extension Content {

    func modify<Value>(
        _ function: @escaping (Line) -> (Value) -> Line,
        _ value: Value
    ) -> some Content {
        modifier(AnyLinesModifier { lines in

            lines.map(function).map { $0(value) }
        })
    }
}

extension Content {

    func modifyFirstLine(_ modifier: @escaping (Line) -> Line) -> some Content {
        self.modifier(FirstLineModifier(modifier: modifier))
    }
}

private struct FirstLineModifier<C: Content>: LinesModifier {

    let modifier: ([Line]) -> [Line]

    init(modifier: @escaping (Line) -> Line) {
        self.modifier = { lines in
            guard let first = lines.first else { return lines }
            return [modifier(first)] + lines.dropFirst()
        }
    }
}
