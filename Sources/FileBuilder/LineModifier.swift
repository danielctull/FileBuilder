
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
