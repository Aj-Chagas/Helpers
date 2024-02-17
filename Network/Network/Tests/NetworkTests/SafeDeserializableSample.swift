import Foundation
@testable import Network

struct SafeDeserializableSample: Decodable {
    struct Credentials: Decodable, Equatable {
        var title: String
        var isValid: Bool
        @SafeDeserializable var descripton: String?
        var price: Int

        enum CodingKeys: String, CodingKey {
            case title = "object_title"
            case isValid = "object_is_valid"
            case descripton = "object_description"
            case price = "object_price"
        }
    }

    @SafeDeserializableArray var credentials: [Credentials]
    @SafeDeserializableArray var missingCredentials: [Credentials]

    enum CodingKeys: String, CodingKey {
        case credentials
        case missingCredentials = "missing_credentials"
    }
}

struct SafeDeserializableSampleWithCustomDecode: Decodable {
    struct Credentials: Decodable, Equatable {
        var title: String
        var isValid: Bool
        @SafeDeserializable var descripton: String?
        var price: Int

        enum CodingKeys: String, CodingKey {
            case title = "object_title"
            case isValid = "object_is_valid"
            case descripton = "object_description"
            case price = "object_price"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.title = try container.decode(String.self, forKey: .title)
            self.isValid = try container.decode(Bool.self, forKey: .isValid)
            self.descripton = try? container.decode(SafeDeserializable<String>.self, forKey: .descripton).value
            self.price = try container.decode(Int.self, forKey: .price)
        }
    }

    @SafeDeserializableArray private(set) var credentials: [Credentials]
    @SafeDeserializableArray private(set) var missingCredentials: [Credentials]

    enum CodingKeys: String, CodingKey {
        case credentials
        case missingCredentials = "missing_credentials"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.credentials = try container.decode(SafeDeserializableArray<Credentials>.self, forKey: .credentials).collection
        self.missingCredentials = try container.decode(SafeDeserializableArray<Credentials>.self, forKey: .missingCredentials).collection
    }
}

