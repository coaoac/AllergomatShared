//
//  User.swift
//  App
//
//  Created by Chaouki, Amine on 2019-01-05.
//

//import Authentication
import Foundation

public struct User: Codable {
    static let _cname = "Users"
    typealias ID = String
    let _id: ID
    var name: String?
    var email: String?
    var realUserStatus: Int
    var role: Role
    var experience: Int
    var appleID: ID?
    var allergies: [Allergy.ID]?
    var products: [Product.ID]?
    var ingredients: [Keyword.ID]?
    let joined: Date

    func updated(from userInfo: BasicUserInfo) -> User {
        User(_id: _id,
             name: userInfo.name,
             email: userInfo.email,
             realUserStatus: userInfo.realUserStatus,
             role: userInfo.role,
             experience: userInfo.experience,
             appleID: appleID,
             allergies: userInfo.allergies,
             products: userInfo.products,
             ingredients: userInfo.ingredients,
             joined: joined)
    }

    struct Credentials: Codable {
        let name: String?
        let email: String?
        let realUserStatus: Int
        let appCode: String
        let source: Source
    }
    
    struct Payment: Codable, Equatable {
        static let _cname = "Payments"
        typealias ID = String
        let _id: ID
        let user: User.ID
        let productID: ProductID
        let paymentId: String
        let date: Date
        let expiry: Date

        enum ProductID: String, Codable {
            case monthly = "app.allergomat.plus.monthly"
            case yearly = "app.allergomat.plus.yearly"
        }
    }
    
    enum Role: String, Codable {
        case normal
        case superuser
        case admin
        case owner
        case invalid
        
        func english() -> String {
            switch self {
                case .normal: return "User"
                case .superuser: return "Superuser"
                case .admin: return "Admin"
                case .owner: return "Owner"
                case .invalid: return "Invalid"
            }
        }
        
        func swedish() -> String {
            switch self {
                case .normal: return "Användare"
                case .owner: return "Ägare"
                case .invalid: return "Ogiltig"
                case .superuser: return "Superuser"
                case .admin: return "Admin"
            }
        }
        
        static func allValid() -> [Role] {
            [.normal, .superuser, .admin, .owner]
        }
        
        static func allAdmin() -> [Role] {
            [.superuser, .admin, .owner]
        }
        
        func isAdmin() -> Bool {
            Self.allAdmin().contains(self)
        }
    }
    
    enum Source: String, Codable {
        case apple
    }
    
    struct WithToken: Codable {
        let user: User
        let token: Token
    }

    struct Token: Codable, Equatable {
        static let _cname = "Tokens"
        typealias ID = String
        let _id: ID
        let user: User.ID
        let date: Date
        var expiryDate: Date
    }


    struct Device: Codable {
        let model: String
        let systemName: String
        let systemVersion: String
    }

    public struct BasicUserInfo: Codable, Equatable {
        let _id: ID
        var name: String?
        var email: String?
        let realUserStatus: Int
        var role: User.Role
        var experience: Int
        var payments: [User.Payment]
        var allergies: [Allergy.ID]?
        var products: [Product.ID]?
        var ingredients: [Keyword.ID]?
        var token: Token.ID

        static func from(user: User, payments: [Payment], token: Token) -> BasicUserInfo {
            BasicUserInfo(_id: user._id,
                          name: user.name,
                          email: user.email,
                          realUserStatus: user.realUserStatus,
                          role: user.role,
                          experience: user.experience,
                          payments: payments,
                          allergies: user.allergies,
                          products: user.products,
                          ingredients: user.ingredients,
                          token: token._id)
        }

        public static func == (lhs: BasicUserInfo, rhs: BasicUserInfo) -> Bool {
            if lhs._id == rhs._id,
                 lhs.name == rhs.name,
                 lhs.email == rhs.email,
                 lhs.realUserStatus == rhs.realUserStatus,
                 lhs.role == rhs.role,
                 lhs.payments.sorted(by: { $0.date > $1.date}) == rhs.payments.sorted(by: { $0.date > $1.date}),
                 lhs.allergies?.sorted(by: { $0 > $1}) == rhs.allergies?.sorted(by: { $0 > $1}),
                 lhs.token == rhs.token,
                 lhs.experience == rhs.experience {
                return true
            } else {
                return false
            }
        }

        func hasValidSubscription() -> Bool {
            self.payments.contains {
                $0.expiry >= Date()
            }
            || role.isAdmin()
        }

        func ulockedFor(experience: Int = 0) -> Bool {
            role.isAdmin() || self.experience >= experience
        }
    }
}

public struct Transaction: Codable {
    static let _cname = "Transactions"
    typealias ID = String
    let _id: ID
    let userID: String?
    let country: String?
    let userAgent: String?
    let collection: String
    let item: String?
    let nature: Nature
    let time: Date
    let source: Source
    
    enum Nature: String, Codable {
        case top, read, update, insert, delete, login, logout, search, history
    }

    enum Source: String, Codable {
        case app, web
    }
}







