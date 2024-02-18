import Foundation

public protocol Serializable {
    func serialize() -> [String: Any]
}

public extension Encodable {
    func serialize() -> [String: Any] {
        guard
            let data = try? JSONEncoder().encode(self),
            let serializedData = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
                as? [String: Any]
        else {
            return [:]
        }

        return serializedData
    }
}
