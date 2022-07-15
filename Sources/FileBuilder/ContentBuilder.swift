
@resultBuilder
public enum ContentBuilder {

    public static func buildPartialBlock<C: Content>(first: C) -> C {
        first
    }

    public static func buildPartialBlock<Accumulated: Content, Next: Content>(
        accumulated: Accumulated,
        next: Next
    ) -> AccumulatedContent<Accumulated, Next> {
        AccumulatedContent(first: accumulated, second: next)
    }

    public static func buildArray<C: Content>(_ array: [C]) -> [C] {
        array
    }

    public static func buildEither<True: Content, False: Content>(
        first: True
    ) -> ConditionalContent<True, False> {
        ConditionalContent(first)
    }

    public static func buildEither<True: Content, False: Content>(
        second: False
    ) -> ConditionalContent<True, False> {
        ConditionalContent(second)
    }

    public static func buildLimitedAvailability<C: Content>(
        _ content: C
    ) -> AnyContent {
        AnyContent(content)
    }

    public static func buildOptional<C: Content>(_ optional: C?) -> C? {
        optional
    }
    public static func buildFinalResult<C: Content>(_ component: C) -> C {
        component
    }
}
