
public enum Indentation: Equatable {
    case tab
    case spaces(Int)
}

// MARK: - Indentation Level

extension Indentation {

    struct Level {
        fileprivate let value: Int
    }

    var string: String {
        switch self {
        case .tab: return "\t"
        case .spaces(let amount): return String(repeating: " ", count: amount)
        }
    }
}

extension Indentation.Level {

    static let zero = Self(value: 0)

    var next: Self {
        Self(value: value + 1)
    }

    func prefix(for indentation: Indentation) -> String {
        String(repeating: indentation.string, count: value)
    }
}
