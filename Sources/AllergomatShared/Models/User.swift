//
//  User.swift
//  App
//
//  Created by Chaouki, Amine on 2019-01-05.
//

//import Authentication
import Foundation

public struct User: Codable, Sendable {
    public static let _cname = "Users"
    public typealias ID = String
    public let _id: ID
    public var name: String?
    public var email: String?
    public var realUserStatus: Int
    public var role: Role
    public var experience: Int
    public var appleID: ID?
    public var allergies: [Allergy.ID]?
    public var products: [Product.ID]?
    public var ingredients: [Keyword.ID]?
    public let joined: Date

    public func updated(from userInfo: BasicUserInfo) -> User {
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

    public struct Credentials: Codable, Sendable {
        public let name: String?
        public let email: String?
        public let realUserStatus: Int
        public let appCode: String
        public let source: Source
    }
    
    public struct Payment: Codable, Equatable, Sendable {
        public static let _cname = "Payments"
        public typealias ID = String
        public let _id: ID
        public let user: User.ID
        public let productID: ProductID
        public let paymentId: String
        public let date: Date
        public let expiry: Date

        public enum ProductID: String, Codable, Sendable {
            case monthly = "app.allergomat.plus.monthly"
            case yearly = "app.allergomat.plus.yearly"
        }
    }
    
    public enum Role: String, Codable, Sendable {
        case normal
        case superuser
        case admin
        case owner
        case invalid
        
        public func english() -> String {
            switch self {
                case .normal: return "User"
                case .superuser: return "Superuser"
                case .admin: return "Admin"
                case .owner: return "Owner"
                case .invalid: return "Invalid"
            }
        }
        
        public func swedish() -> String {
            switch self {
                case .normal: return "Användare"
                case .owner: return "Ägare"
                case .invalid: return "Ogiltig"
                case .superuser: return "Superuser"
                case .admin: return "Admin"
            }
        }
        
        public static func allValid() -> [Role] {
            [.normal, .superuser, .admin, .owner]
        }
        
        public static func allAdmin() -> [Role] {
            [.superuser, .admin, .owner]
        }
        
        public func isAdmin() -> Bool {
            Self.allAdmin().contains(self)
        }
    }
    
    public enum Source: String, Codable, Sendable {
        case apple
    }
    
    public struct WithToken: Codable, Sendable {
        public let user: User
        public let token: Token
    }

    public struct Token: Codable, Equatable, Sendable {
        public static let _cname = "Tokens"
        public typealias ID = String
        public let _id: ID
        public let user: User.ID
        public let date: Date
        public var expiryDate: Date
    }


    public struct Device: Codable, Sendable {
        public let model: String
        public let systemName: String
        public let systemVersion: String
    }

    public struct BasicUserInfo: Codable, Equatable, Sendable {
        public let _id: ID
        public var name: String?
        public var email: String?
        public let realUserStatus: Int
        public var role: User.Role
        public var experience: Int
        public var payments: [User.Payment]
        public var allergies: [Allergy.ID]?
        public var products: [Product.ID]?
        public var ingredients: [Keyword.ID]?
        public var token: Token.ID

        public static func from(user: User, payments: [Payment], token: Token) -> BasicUserInfo {
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

        public func hasValidSubscription() -> Bool {
            self.payments.contains {
                $0.expiry >= Date()
            }
            || role.isAdmin()
        }

        public func ulockedFor(experience: Int = 0) -> Bool {
            role.isAdmin() || self.experience >= experience
        }
    }
}









