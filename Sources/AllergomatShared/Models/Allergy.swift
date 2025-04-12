//
//  Allergy.swift
//  App
//
//  Created by Chaouki, Amine on 2019-01-05.
//

import Foundation
import Localizer

public struct Allergy: Codable, Hashable, Sendable, Identifiable {
    public static let _cname = "Allergies"
    public typealias ID = String
    public let _id: ID
    public let name: [LocalizedString]
    public let info: [LocalizedString]
    public let web: [LocalizedString]
    public let beta: Bool
    
    public var id: String {
        return _id
    }
    
    public init(_id: ID, name: [LocalizedString], info: [LocalizedString], web: [LocalizedString], beta: Bool) {
        self._id = _id
        self.name = name
        self.info = info
        self.web = web
        self.beta = beta
    }

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
        
        public init(allergy: Allergy, active: Bool? = nil) {
            self.allergy = allergy
            self.active = active
        }
    }

    public struct AllergyProba: Codable, Hashable, Sendable, Identifiable {
        public let allergy: Allergy.ID
        public var proba: Proba
        public var id: Allergy.ID {
            return allergy
        }
        
        public init(allergy: Allergy.ID, proba: Proba) {
            self.allergy = allergy
            self.proba = proba
        }
    }
}
