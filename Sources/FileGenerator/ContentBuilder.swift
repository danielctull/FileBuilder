
@resultBuilder
public enum ContentBuilder {

    // To remove ambiguity errors, all Content is type erased to the following
    // Component and FinalResult types. This also allows us to more easily see
    // the flow of the calls through the result builder functions.

    public struct Component<C: Content> {
        let content: C
    }

//    public struct FinalResult: Content {
//        fileprivate let generate: (Indentation) -> [Line]
//        public var body: some Content {
//            Builtin(_generate: generate)
//        }
//    }

    public static func buildExpression<C: Content>(_ expression: C) -> Component<C> {
        Component(content: expression)
    }

    public static func buildPartialBlock<C: Content>(first: Component<C>) -> Component<C> {
        first
    }

    public static func buildPartialBlock<A: Content, B: Content>(accumulated: Component<A>, next: Component<B>) -> Component<some Content> {
        Component(content: Builtin { indentation in
            let first = accumulated.content.generate(indentation: indentation)
            let second = next.content.generate(indentation: indentation)
            return first + second
        })
    }

    public static func buildArray<C: Content>(_ array: [Component<C>]) -> Component<some Content> {
        Component(content: Builtin { indentation in
            array.flatMap { $0.content.generate(indentation: indentation) }
        })
    }

    public static func buildEither<C: Content>(first: Component<C>) -> Component<C> {
        first
    }

    public static func buildEither<C: Content>(second: Component<C>) -> Component<C> {
        second
    }

    public static func buildOptional<C: Content>(_ optional: Component<C>?) -> Component<C?> {
        Component(content: optional?.content)
    }

    public static func buildFinalResult<C: Content>(_ component: Component<C>) -> C {
        component.content
    }
}
