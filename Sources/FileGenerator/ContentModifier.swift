
public protocol ContentModifier {
    associatedtype C
    associatedtype Body: Content

    func body(content: C) -> Body
}

extension Content {

    public func modifier<Modifier: ContentModifier>(
        _ modifier: Modifier
    ) -> ModifiedContent<Self, Modifier> {
        ModifiedContent(content: self, modifier: modifier)
    }
}

public struct ModifiedContent<C, Modifier> {
    fileprivate let content: C
    fileprivate let modifier: Modifier
}

extension ModifiedContent: Content where C: Content, Modifier: ContentModifier, C == Modifier.C {

    public var body: some Content {
        Builtin { environment in
            environment.install(on: modifier)
            return modifier
                .body(content: content)
                .generate(environment: environment)
        }
    }
}
