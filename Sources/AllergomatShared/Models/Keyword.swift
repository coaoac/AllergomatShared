//
//  Keyword.swift
//  Allergiskan
//
//  Created by Chaouki, Amine on 2020-01-10.
//  Copyright © 2020 AllergyKlubb. All rights reserved.
//

import Foundation

public struct Keyword: Codable, Hashable, Sendable {
    public static let _cname = "Keywords"
    public typealias ID = String
    public let _id: ID // word
    public var isIngredient: Bool
    public var allergies: [Allergy.AllergyProba] //by default if an allergy is not relevant it is not included
    public var updated: Date
    
    public init(_id: ID, isIngredient: Bool, allergies: [Allergy.AllergyProba], updated: Date) {
        self._id = _id
        self.isIngredient = isIngredient
        self.allergies = allergies
        self.updated = updated
    }

    public struct List: Codable, Sendable {
        public let items: [Keyword]
        
        public init(items: [Keyword]) {
            self.items = items
        }
    }

    public struct One: Codable, Sendable {
        public let name: Keyword.ID
        
        public init(name: Keyword.ID) {
            self.name = name
        }
    }

    public struct Limit_ExcludedIds_String: Codable, Sendable {
        public let limit: Int
        public let excludedIds: [Keyword.ID]
        public let string: String?
        
        public init(limit: Int, excludedIds: [Keyword.ID], string: String?) {
            self.limit = limit
            self.excludedIds = excludedIds
            self.string = string
        }
    }

    public func customizedAllergy(_ allergyProba: Allergy.AllergyProba) -> Bool {
        self.allergies.reduce(false) { result, nextAllergyProba in
            if nextAllergyProba.allergy == allergyProba.allergy {
                return result || nextAllergyProba.proba != allergyProba.proba
            } else {
                return result || false
            }
        }
    }

    public func maxProba(for allergies: [Allergy.ID]) -> Proba {
        var proba: Proba = .none
        let relevant = self.allergies.filter { allergies.contains($0.allergy) }
        for allergy in relevant {
            if proba < allergy.proba {
                proba = allergy.proba
            }
        }
        return proba
    }

    public func isAllergyRelevant(_ allergies: [Allergy.ID]) -> Bool {
        for allergy in self.allergies {
            if allergies.contains(allergy.allergy) {
                return true
            }
        }
        return false
    }
}

extension Keyword: Equatable {
    public static func == (lhs: Keyword, rhs: Keyword) -> Bool {
        lhs._id == rhs._id
            && lhs.isIngredient == rhs.isIngredient
            && lhs.allergies.reduce(true) { result, nextAllergyProba in
                if let rAllergyProba = rhs.allergies.first(where: { $0.allergy == nextAllergyProba.allergy }) {
                    return result && rAllergyProba.proba == nextAllergyProba.proba
                } else {
                    return false
                }
            }
            && rhs.allergies.reduce(true) { result, nextAllergyProba in
                if let lAllergyProba = lhs.allergies.first(where: { $0.allergy == nextAllergyProba.allergy }) {
                    return result && lAllergyProba.proba == nextAllergyProba.proba
                } else {
                    return false
                }
        }
    }
}

