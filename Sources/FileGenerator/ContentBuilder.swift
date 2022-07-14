
@resultBuilder
public enum ContentBuilder {

    // To remove ambiguity errors, all Content is type erased to the following
    // Component and FinalResult types. This also allows us to more easily see
    // the flow of the calls through the result builder functions.

    public struct Component {
        fileprivate let generate: (Indentation) -> [Line]
    }

    public struct FinalResult: Content {
        fileprivate let generate: (Indentation) -> [Line]
        public var body: some Content {
            Builtin(_generate: generate)
        }
    }

    public static func buildExpression(_ expression: some Content) -> Component {
        Component(generate: expression.generate)
    }

    public static func buildPartialBlock(first: Component) -> Component {
        first
    }

    public static func buildPartialBlock(accumulated: Component, next: Component) -> Component {
        Component { indentation in
            let first = accumulated.generate(indentation)
            let second = next.generate(indentation)
            return first + second
        }
    }

    public static func buildArray(_ array: [Component]) -> Component {
        Component { indentation in
            array.flatMap { $0.generate(indentation) }
        }
    }

    public static func buildEither(first: Component) -> Component {
        first
    }

    public static func buildEither(second: Component) -> Component {
        second
    }

    public static func buildOptional(_ optional: Component?) -> Component {
        Component { indentation in
            switch optional {
            case .none: return []
            case .some(let component): return component.generate(indentation)
            }
        }
    }

    public static func buildFinalResult(_ component: Component) -> FinalResult {
        FinalResult(generate: component.generate)
    }
}
