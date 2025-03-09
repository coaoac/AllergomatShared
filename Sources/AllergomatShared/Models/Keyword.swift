//
//  Keyword.swift
//  Allergiskan
//
//  Created by Chaouki, Amine on 2020-01-10.
//  Copyright © 2020 AllergyKlubb. All rights reserved.
//

import Foundation

public struct Keyword: Codable, Hashable {
    public static let _cname = "Keywords"
    public typealias ID = String
    public let _id: ID // word
    public var isIngredient: Bool
    public var allergies: [Allergy.AllergyProba] //by default if an allergy is not relevant it is not included
    public var updated: Date

    public struct List: Codable {
        public let items: [Keyword]
    }

    public struct One: Codable {
        public let name: Keyword.ID
    }
/*
    struct Correction: Codable, Hashable {
        static let _cname = "KeywordCorrections"
        typealias ID = String

        let _id: ID
        let user: User.ID
        let keyword: Keyword.ID
        var isIngredient: Bool? // nil means not corrected
        var allergies: [Allergy.AllergyProba] // only includes edited allergies. if empty means delete the correction
        var status: Status
        var updated: Date

        init(userID: User.ID, keyword: Keyword.ID, isIngredient: Bool?, allergies: [Allergy.AllergyProba], status: Status, update: Date) {
            self.user = userID
            self.keyword = keyword
            self.isIngredient = isIngredient
            self.allergies = allergies
            self.status = status
            self.updated = update
            self._id = userID + "+" + keyword
        }

        struct Review: Codable {
            var correction: Correction
            let approval: Bool
        }

        struct OneIfExists: Codable {
            let correction: Correction?
        }
    }

    public struct WithCorrection: Codable, Hashable {
        let keywordID: Keyword.ID
        var keyword: Keyword
        var correction: Correction?


        private func correctedAllergies() -> [Allergy.AllergyProba] {
            if let correction = correction {
                if correction.isIngredient == false {
                    return []
                } else {
                    var allergies = keyword.allergies.map { ap -> Allergy.AllergyProba in
                        if let cap = correction.allergies.first(where: { $0.allergy == ap.allergy }) {
                            return cap
                        }
                        return ap
                    }

                    for cap in correction.allergies {
                        if !allergies.contains(where: { ap in
                            ap.allergy == cap.allergy
                        }) {
                            allergies.append(cap)
                        }
                    }
                    return allergies
                }
            }
            return keyword.allergies
        }

        func corrected() -> Keyword {
            Keyword(_id: keywordID,
                    isIngredient: correction?.isIngredient ?? keyword.isIngredient,
                    allergies: correctedAllergies(),
                    updated: correction?.updated ?? keyword.updated)
        }

        struct List: Codable {
            let ingredientsAndCorrections: [Keyword.WithCorrection]
        }
    }
*/
    public struct Limit_ExcludedIds_String: Codable {
        public let limit: Int
        public let excludedIds: [Keyword.ID]
        public let string: String?
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
/*
 extension Keyword.Correction: Equatable {
 public static func == (lhs: Keyword.Correction, rhs: Keyword.Correction) -> Bool {
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
 */
