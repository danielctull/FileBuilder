
public struct File<C: Content> {
    private let environment: EnvironmentValues
    private let _content: C
}

extension File {

    public init(
        indentation: Indentation = .spaces(4),
        @ContentBuilder build: () -> C
    ) {
        var environment = EnvironmentValues()
        environment.indentation = indentation
        self.init(environment: environment, _content: build())
    }
}

extension File {

    public var content: String {
        _content
            .generate(environment: environment)
            .map(\.rawValue)
            .joined(separator: "\n")
    }
}
