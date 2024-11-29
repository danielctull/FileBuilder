
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
    @Mutable private var values: EnvironmentValues?

    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        guard let values else { fatalError("Environment values not set.") }
        return values[keyPath: keyPath]
    }
}

@propertyWrapper
private final class Mutable<Value> {
    var wrappedValue: Value
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

private protocol DynamicProperty {
    func install(_ values: EnvironmentValues)
}

extension Environment: DynamicProperty {

    fileprivate func install(_ values: EnvironmentValues) {
        self.values = values
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
