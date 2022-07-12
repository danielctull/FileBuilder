
public enum AccessLevel: CustomStringConvertible {
    case none
    case `private`
    case `public`
    case `internal`
    case `fileprivate`

    public var description: String {
        switch self {
        case .none: return ""
        case .private: return "private "
        case .public: return "public "
        case .internal: return "internal "
        case .fileprivate: return "fileprivate "
        }
    }
}
