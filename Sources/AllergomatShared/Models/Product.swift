import Foundation

public struct Product: Codable, Equatable {
    static let _cname = "Products"
    typealias ID = String

    let _id: ID // EAN
    var name: String
    var producer: String?
    var origin: Country.ID?
    var ingredients: String?
    var image: Picture.ID?
    var updated: Date
    var dataSource: Source

    enum Source: String, Codable {
        case ica
        case coop
        case app
    }

    struct WithPicture: Codable {
        let product: Product
        let picture: Picture?
    }
    struct EAN: Codable {
        let ean: ID
    }

    struct Ingredients: Codable {
        let ingredients: String
    }

    struct EAN_and_UserID: Codable {
        let ean: ID
        let userID: User.ID?
    }

    struct EANs: Codable {
        let eans: [ID]
    }

    struct List: Codable {
        let items: [Product]
    }

    struct Extended: Codable {
        let product: Product
        let ingredients: [Keyword]
    }

    // MARK: - Correction
    struct Correction: Codable, Equatable {
        static let _cname = "ProductCorrections"
        typealias ID = String

        let _id: ID
        let product: Product.ID
        let user: User.ID
        var name: String?
        var producer: String?
        var origin: Country.ID?
        var ingredients: String?
        var comment: String?
        var image: Picture.ID?
        var status: Status
        var updated: Date

        init(product: Product.ID, user: User.ID, status: Status, updated: Date, name: String? = nil, producer: String? = nil, origin: Country.ID? = nil, ingredients: String? = nil, comment: String? = nil, image: Picture.ID? = nil) {

            self.product = product
            self.user = user
            self.name = name
            self.producer = producer
            self.origin = origin
            self.ingredients = ingredients
            self.comment = comment
            self.image = image
            self.status = status
            self.updated = updated
            self._id = user + product
        }

        struct Review: Codable {
            var correction: Correction
            let approval: Bool
        }

        struct OneIfExists: Codable {
            let correction: Correction?
        }
        
        
    }
    
    struct WithCorrection: Codable {
        let ean: Product.ID
        var product: Product?
        var correction: Correction?

        func user() -> User.ID? {
            correction?.user
        }
        struct List: Codable {
            let items: [WithCorrection]
        }

        func id() -> String {
            ean + " + " + (user() ?? "")
        }

        func corrected() -> Product? {

            if let correction = correction, let name = correction.name ?? product?.name {
                return Product(_id: ean,
                               name: name,
                               producer: correction.producer == "" ? nil : correction.producer ?? product?.producer,
                               origin: correction.origin == "" ? nil : correction.origin ?? product?.origin,
                               ingredients: correction.ingredients == "" ? nil : correction.ingredients ?? product?.ingredients,
                               image: correction.image ?? product?.image,
                               updated: correction.updated,
                               dataSource: .app)
            }
            return product
        }

        func isCorrected() -> Bool {
            corrected() != product
        }
        func isNew() -> Bool {
            product == nil
        }
    }



    struct ID_RawIngredients: Codable {
        let id: Product.ID
        let raw: String
    }

    struct Limit_String_ExcludedIds: Codable {
        let limit: Int
        let string: String?
        let excludedIds: [Product.ID]
    }
}


