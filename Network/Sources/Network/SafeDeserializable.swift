import Foundation

@propertyWrapper public struct SafeDeserializable<T>: Decodable, Equatable where T: Decodable, T: Equatable {
    private(set) var value: T?

    public init(wrappedValue: T?) {
        self.value = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(OptionalDeserializable<T>.self).value
    }

    public var wrappedValue: T? {
        get { value }
        set { self.value = newValue }
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: SafeDeserializable<T>.Type, forKey key: Self.Key
    ) throws -> SafeDeserializable<T> where T: Decodable {
        return try decodeIfPresent(type, forKey: key) ?? SafeDeserializable<T>(wrappedValue: nil)
    }
}

@propertyWrapper public struct SafeDeserializableArray<T>: Decodable, Equatable where T: Decodable, T: Equatable {
    private(set) var collection: [T]

    public init(wrappedValue: [T]) {
        self.collection = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.collection = try container.decode(OptionalDeserializableArray<T>.self).value
    }

    public var wrappedValue: [T] {
        get { collection }
        set { self.collection = newValue }
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: SafeDeserializableArray<T>.Type, forKey key: Self.Key
    ) throws -> SafeDeserializableArray<T> where T: Decodable {
        return try decodeIfPresent(type, forKey: key) ?? SafeDeserializableArray<T>(wrappedValue: [])
    }
}
