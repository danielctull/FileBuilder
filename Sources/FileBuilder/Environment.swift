
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
private final class Box<Value> {
    var wrappedValue: Value
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

private protocol DynamicProperty {
    func install(_ environment: EnvironmentValues)
}

extension Environment: DynamicProperty {

    fileprivate func install(_ environment: EnvironmentValues) {
        self.environment = environment
    }
}

extension EnvironmentValues {

    func install<Target>(on target: Target) {
        let mirror = Mirror(reflecting: target)
        for child in mirror.children {
            if let property = child.value as? DynamicProperty {
                property.install(self)
            }
        }
    }
}
