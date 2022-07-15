
public protocol ContentModifier {
    associatedtype C
    associatedtype Body: Content

    @ContentBuilder
    func body(content: C) -> Body
}

extension Content {

    public func modifier<Modifier: ContentModifier>(
        _ modifier: Modifier
    ) -> ModifiedContent<Self, Modifier> where Modifier.C == Self {
        ModifiedContent(content: self, modifier: modifier)
    }
}

public struct ModifiedContent<C, Modifier> {
    fileprivate let content: C
    fileprivate let modifier: Modifier
}

extension ModifiedContent: Content where C: Content, Modifier: ContentModifier, C == Modifier.C {

    public var body: some Content {
        BuiltinContent { environment in
            environment.install(on: modifier)
            return modifier
                .body(content: content)
                .generate(environment: environment)
        }
    }
}
