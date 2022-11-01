
@resultBuilder
public enum ContentBuilder {

    public static func buildPartialBlock<C: TextContent>(first: C) -> C {
        first
    }

    public static func buildPartialBlock<Accumulated: TextContent, Next: TextContent>(
        accumulated: Accumulated,
        next: Next
    ) -> AccumulatedContent<Accumulated, Next> {
        AccumulatedContent(first: accumulated, second: next)
    }

    public static func buildArray<C: TextContent>(_ array: [C]) -> [C] {
        array
    }

    public static func buildEither<True: TextContent, False: TextContent>(
        first: True
    ) -> ConditionalContent<True, False> {
        ConditionalContent(first)
    }

    public static func buildEither<True: TextContent, False: TextContent>(
        second: False
    ) -> ConditionalContent<True, False> {
        ConditionalContent(second)
    }

    public static func buildLimitedAvailability<C: TextContent>(
        _ content: C
    ) -> AnyContent {
        AnyContent(content)
    }

    public static func buildOptional<C: TextContent>(_ optional: C?) -> C? {
        optional
    }
    public static func buildFinalResult<C: TextContent>(_ component: C) -> C {
        component
    }
}
