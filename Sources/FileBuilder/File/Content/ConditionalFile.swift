
import Foundation

extension ConditionalContent: File where True: File, False: File {

    public var body: some File {
        BuiltinFile { directory, environment in
            switch value {
            case let .true(file):
                try file.write(in: directory, environment: environment)
            case let .false(file):
                try file.write(in: directory, environment: environment)
            }
        }
    }
}
