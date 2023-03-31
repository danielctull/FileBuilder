
import Foundation

extension Either: File where First: File, Second: File {

    public var file: some File {
        BuiltinFile { directory, environment in
            switch value {
            case let .first(file):
                try file.write(in: directory, environment: environment)
            case let .second(file):
                try file.write(in: directory, environment: environment)
            }
        }
    }
}
