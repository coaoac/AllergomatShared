import Foundation
import Localizer
public struct Product: Codable, Equatable, Sendable {
    public static let _cname = "Products"
    public typealias ID = String

    public let _id: ID  // EAN
    public var name: String
    public var nameLocalized: LocalizedStrings?
    public var producer: String?
    public var origin: Country.ID?
    public var ingredients: String?
    public var ingredientsLocalized: LocalizedStrings?
    public var image: Picture.ID?
    public var updated: Date
    public var dataSource: Source
    public var reviewed: Date?

    public init(
        _id: ID, name: String, producer: String? = nil, origin: Country.ID? = nil,
        ingredients: String? = nil, ingredientsLocalized: LocalizedStrings? = nil, image: Picture.ID? = nil, updated: Date, dataSource: Source,
        reviewed: Date? = nil
    ) {
        self._id = _id
        self.name = name
        self.producer = producer
        self.origin = origin
        self.ingredients = ingredients
        self.ingredientsLocalized = ingredientsLocalized
        self.image = image
        self.updated = updated
        self.dataSource = dataSource
        self.reviewed = reviewed
    }

    public enum Source: String, Codable, Sendable {
        case ica
        case coop
        case ai
        case web
        case app
        case server
        case manual
    }

    public struct WithPicture: Codable, Sendable {
        public let product: Product
        public let picture: Picture?

        public init(product: Product, picture: Picture?) {
            self.product = product
            self.picture = picture
        }
    }
    public struct EAN: Codable, Sendable {
        public let ean: ID
        public init(ean: ID) {
            self.ean = ean
        }
    }

    public struct Ingredients: Codable, Sendable {
        public let ingredients: String
        public init(ingredients: String) {
            self.ingredients = ingredients
        }
    }

    public struct EAN_and_UserID: Codable, Sendable {
        public let ean: ID
        public let userID: User.ID?
        public init(ean: ID, userID: User.ID?) {
            self.ean = ean
            self.userID = userID
        }
    }

    public struct EANs: Codable, Sendable {
        public let eans: [ID]
        public init(eans: [ID]) {
            self.eans = eans
        }
    }

    public struct List: Codable, Sendable {
        public let items: [Product]
        public init(items: [Product]) {
            self.items = items
        }
    }

    public struct Extended: Codable, Sendable {
        public let product: Product
        public let ingredients: [Keyword]
        public init(product: Product, ingredients: [Keyword]) {
            self.product = product
            self.ingredients = ingredients
        }
    }

    public struct ID_RawIngredients: Codable, Sendable {
        public let id: Product.ID
        public let raw: String
        public init(id: Product.ID, raw: String) {
            self.id = id
            self.raw = raw
        }
    }

    public struct Limit_String_ExcludedIds: Codable, Sendable {
        public let limit: Int
        public let string: String?
        public let excludedIds: [Product.ID]
        public init(limit: Int, string: String?, excludedIds: [Product.ID]) {
            self.limit = limit
            self.string = string
            self.excludedIds = excludedIds
        }
    }
}
