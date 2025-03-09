//
//  Allergy.swift
//  App
//
//  Created by Chaouki, Amine on 2019-01-05.
//

import Foundation

public struct Allergy: Codable, Hashable, Sendable {
    public static let _cname = "Allergies"
    public typealias ID = String
    public let _id: ID
    public let name: LocalizedString
    public let info: LocalizedString
    public let web: LocalizedString
    public let beta: Bool

    public func maxProba(ingredients: [Keyword?]) -> AllergyProba {
        ingredients.map { ingredient in
            ingredient?.allergies.first{ $0.allergy == _id } ?? Allergy.AllergyProba(allergy: self._id, proba: .none)
        }.sorted { lhs, rhs in
            return lhs.proba > rhs.proba
        }.first ?? Allergy.AllergyProba(allergy: self._id, proba: .none)
    }

    public struct Reduce: Codable, Sendable {
        public let allergy: Allergy
        public var active: Bool?

        public func isActive() -> Bool {
            if active == true {
                return true
            } else {
                return false
            }
        }
    }

    public struct AllergyProba: Codable, Hashable, Sendable  {
        public let allergy: Allergy.ID
        public var proba: Proba

        public struct WithOriginal: Codable, Hashable, Sendable  {
            public var allergyProba: Allergy.AllergyProba
            public let original: Allergy.AllergyProba
            
            public func changed() -> Bool {
                allergyProba != original
            }
            /*
            public func status(ingredients: [Keyword.WithCorrection?]) -> Status? {
                let relevantIngredients = ingredients.filter {
                    $0?.corrected().allergies.contains { $0.allergy == allergyProba.allergy } ?? false
                }
                if let relevantIngredient = relevantIngredients.sorted(by: { ($0?.correction?.status ?? .none) < ($1?.correction?.status ?? .none)
                }).first {
                    return relevantIngredient?.correction?.status
                } else {
                    return nil
                }
            }
            */
        }
    }
}
