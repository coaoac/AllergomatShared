//
//  Allergy.swift
//  App
//
//  Created by Chaouki, Amine on 2019-01-05.
//

import Foundation

struct Allergy: Codable, Hashable {
    static let _cname = "Allergies"
    typealias ID = String
    let _id: ID
    let name: LocalizedString
    let info: LocalizedString
    let web: LocalizedString
    let beta: Bool

    func maxProba(ingredients: [Keyword?]) -> AllergyProba {
        ingredients.map { ingredient in
            ingredient?.allergies.first{ $0.allergy == _id } ?? Allergy.AllergyProba(allergy: self._id, proba: .none)
        }.sorted { lhs, rhs in
            return lhs.proba > rhs.proba
        }.first ?? Allergy.AllergyProba(allergy: self._id, proba: .none)
    }

    struct Reduce: Codable {
        let allergy: Allergy
        var active: Bool?

        func isActive() -> Bool {
            if active == true {
                return true
            } else {
                return false
            }
        }
    }

    struct AllergyProba: Codable, Hashable {
        let allergy: Allergy.ID
        var proba: Proba

        struct WithOriginal: Codable, Hashable {
            var allergyProba: Allergy.AllergyProba
            let original: Allergy.AllergyProba

            func changed() -> Bool {
                allergyProba != original
            }

            func status(ingredients: [Keyword.WithCorrection?]) -> Status? {
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
        }
    }
}
