//
//  Keyword.swift
//  Allergiskan
//
//  Created by Chaouki, Amine on 2020-01-10.
//  Copyright © 2020 AllergyKlubb. All rights reserved.
//

import Foundation
import Localizer

public struct Allergen: Codable, Hashable, Sendable, Identifiable {
    public static let _cname = "Allergens"
    public typealias ID = String
    public let _id: ID  // code
    public var name: LocalizedStringList
    public var allergies: [Allergy.AllergyProba]
    public var id: String {
        return _id
    }
    public var updated: Date
    public var source: Source
    public var approved: Date?

    public init(
        _id: ID, name: LocalizedStringList, allergies: [Allergy.AllergyProba], source: Source,
        updated: Date, approved: Date? = nil
    ) {
        self._id = _id
        self.name = name
        self.allergies = allergies
        self.updated = updated
        self.source = source
        self.approved = approved
    }

    public struct List: Codable, Sendable {
        public let items: [Allergen]

        public init(items: [Allergen]) {
            self.items = items
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

    public enum Source: String, Codable, Sendable {
        case ai
        case manual
    }
}

extension Allergen: Equatable {
    public static func == (lhs: Allergen, rhs: Allergen) -> Bool {
        lhs.name == rhs.name
            && lhs.allergies.reduce(true) { result, nextAllergyProba in
                if let rAllergyProba = rhs.allergies.first(where: {
                    $0.allergy == nextAllergyProba.allergy
                }) {
                    return result && rAllergyProba.proba == nextAllergyProba.proba
                } else {
                    return false
                }
            }
            && rhs.allergies.reduce(true) { result, nextAllergyProba in
                if let lAllergyProba = lhs.allergies.first(where: {
                    $0.allergy == nextAllergyProba.allergy
                }) {
                    return result && lAllergyProba.proba == nextAllergyProba.proba
                } else {
                    return false
                }
            }
    }
}
