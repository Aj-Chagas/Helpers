import Foundation
import os.log

public struct OptionalDeserializable<T>: Decodable where T: Decodable {
    public let value: T?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(T.self)
        } catch {
            self.value = nil
            os_log("OptionalDeserializable: %@", log: OSLog.default, type: .error, error as CVarArg)
        }
    }
}

public struct OptionalDeserializableArray<T>: Decodable where T: Decodable {
    public let value: [T]

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode([OptionalDeserializable<T>].self).compactMap { $0.value }
        } catch {
            self.value = [T]()
            os_log("OptionalDeserializableArray: %@", log: OSLog.default, type: .error, error as CVarArg)
        }
    }
}
