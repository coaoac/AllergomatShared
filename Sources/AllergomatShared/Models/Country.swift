//
//  Country.swift
//  AllergiskPackageDescription
//
//  Created by Chaouki, Amine on 2019-01-12.
//

import Foundation

struct Country: Codable {
    static let _cname = "Countries"
    typealias ID = String
    let _id: ID //alpha2
    let name: Name
    let tld: [String]
    let ccn3: String
    let cca3: String //alpha3
    let cioc: String
    let independent: Bool?
    let status: Status
    let currencies: [String: Currency]
    let idd: Idd
    let capital: [String]
    let altSpellings: [String]
    let region: Region
    let subregion: String
    let languages: [String: String]
    var translations: [String: Translation]
    let latlng: [Double]
    let demonym: String
    let landlocked: Bool
    let borders: [String]
    let area: Double
    let flag: String
    let union: Union
    let unionflag: String

    // MARK: Name
    struct Name: Codable {
        let common: String
        let official: String
        let native: [String: Translation]
    }

    // MARK: Translation
    struct Translation: Codable {
        let official: String
        let common: String
    }

    // MARK: Currency
    struct Currency: Codable {
        let name: String
        let symbol: String
    }

    // MARK: Idd
    struct Idd: Codable {
        let root: String
        let suffixes: [String]
    }

    enum Region: String, Codable {
        case africa = "Africa"
        case americas = "Americas"
        case antarctic = "Antarctic"
        case asia = "Asia"
        case europe = "Europe"
        case oceania = "Oceania"
    }

    enum Status: String, Codable {
        case officially_assigned
        case user_assigned
    }

    enum Union: String, Codable {
        case none = ""
        case eu
    }

    struct CountryID: Codable {
        let id: Country.ID
    }

    struct Simple: Codable, Hashable {
        let _id: Country.ID
        let english: String
        let swedish: String
        let flag: String

        static func none() -> Simple {
            Simple(_id: "", english: "", swedish: "", flag: "")
        }

        struct List: Codable {
            let items: [Simple]
        }
    }



    func simple() -> Simple {
        let translation = name.native["swe"]?.common ?? name.common
        return Country.Simple(_id: _id, english: name.common, swedish: translation, flag: flag)
    }


}



struct Country_Simple: Codable {
    let name_en, name_se, flag, alpha2Code, alpha3Code, numCode, region: String
    let isEU: Bool
}
