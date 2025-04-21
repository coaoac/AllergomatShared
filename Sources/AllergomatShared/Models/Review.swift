import Foundation

public struct Review: Codable, Sendable, Equatable {
    public static let _cname = "Reviews"
    public typealias ID = String
    public let _id: ID
    public let user: User.ID
    public let product: Product.ID?
    public let ingredient: Ingredient.ID?
    public let allergy: Allergy.ID?
    public let date: Date
    public let text: String?
    public let approved: Bool?

    public static func empty() -> Review {
        return Review(
            _id: "",
            user: "",
            product: nil,
            ingredient: nil,
            allergy: nil,
            date: Date(),
            text: nil,
            approved: nil
        )
    }

    public struct User_Product_Review: Codable, Sendable {
        public let user: User.ID
        public let product: Product.ID
        public let review: Review?
        public init(user: User.ID, product: Product.ID, review: Review?) {
            self.user = user
            self.product = product
            self.review = review
        }
    }

    public init(
        _id: ID, user: User.ID, product: Product.ID?, ingredient: Ingredient.ID? = nil, allergy: Allergy.ID? = nil,
        date: Date, text: String?, approved: Bool? = nil
    ) {
        self._id = _id
        self.user = user
        self.product = product
        self.ingredient = ingredient
        self.allergy = allergy
        self.date = date
        self.text = text
        self.approved = approved
    }

    public init(for product: Product.ID, user: User.ID, date: Date = Date(), text: String?, approved: Bool? = nil) {
        self._id = "productReview - Product: \(product) - User: \(user)"
        self.user = user
        self.product = product
        self.ingredient = nil
        self.allergy = nil
        self.date = date
        self.text = text
        self.approved = approved
    }

    public struct ProductStats: Codable, Sendable {
        public let product: Product.ID
        public let positive: Int
        public let negative: Int
        public init(product: Product.ID, positive: Int, negative: Int) {
            self.product = product
            self.positive = positive
            self.negative = negative
        }
    }
}