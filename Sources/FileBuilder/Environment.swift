
public protocol EnvironmentKey {
    associatedtype Value
    static var defaultValue: Value { get }
}

public struct EnvironmentValues {

    private var values: [ObjectIdentifier: Any] = [:]

    public subscript<Key: EnvironmentKey>(key: Key.Type) -> Key.Value {
        get { values[ObjectIdentifier(key)] as? Key.Value ?? Key.defaultValue }
        set { values[ObjectIdentifier(key)] = newValue }
    }
}

// MARK: - Modifier

struct EnvironmentModifier<Content> {
    let content: Content
    let modify: (inout EnvironmentValues) -> Void
}

// MARK: - Property Wrapper

@propertyWrapper
public struct Environment<Value> {
    private let keyPath: KeyPath<EnvironmentValues, Value>
    @Box private var environment: EnvironmentValues?

    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        guard let environment else { fatalError("Environment not set.") }
        return environment[keyPath: keyPath]
    }
}

@propertyWrapper
private final class Box<A> {
    var wrappedValue: A
    init(wrappedValue: A) {
        self.wrappedValue = wrappedValue
    }
}

private protocol SetEnvironmentValues {
    func setEnvironmentValues(_ environment: EnvironmentValues)
}

extension Environment: SetEnvironmentValues {

    fileprivate func setEnvironmentValues(_ environment: EnvironmentValues) {
        self.environment = environment
    }
}

extension EnvironmentValues {

    func install<Target>(on target: Target) {
        let mirror = Mirror(reflecting: target)
        for child in mirror.children {
            if let property = child.value as? SetEnvironmentValues {
                property.setEnvironmentValues(self)
            }
        }
    }
}
