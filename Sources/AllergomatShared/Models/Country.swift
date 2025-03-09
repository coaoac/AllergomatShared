//
//  Country.swift
//  AllergiskPackageDescription
//
//  Created by Chaouki, Amine on 2019-01-12.
//

import Foundation

public struct Country: Codable {
    public static let _cname = "Countries"
    public typealias ID = String
    public let _id: ID //alpha2
    public let name: Name
    public let tld: [String]
    public let ccn3: String
    public let cca3: String //alpha3
    public let cioc: String
    public let independent: Bool?
    public let status: Status
    public let currencies: [String: Currency]
    public let idd: Idd
    public let capital: [String]
    public let altSpellings: [String]
    public let region: Region
    public let subregion: String
    public let languages: [String: String]
    public var translations: [String: Translation]
    public let latlng: [Double]
    public let demonym: String
    public let landlocked: Bool
    public let borders: [String]
    public let area: Double
    public let flag: String
    public let union: Union
    public let unionflag: String

    // MARK: Name
    public struct Name: Codable {
        public let common: String
        public let official: String
        public let native: [String: Translation]
    }

    // MARK: Translation
    public struct Translation: Codable {
        public let official: String
        public let common: String
    }

    // MARK: Currency
    public struct Currency: Codable {
        public let name: String
        public let symbol: String
    }

    // MARK: Idd
    public struct Idd: Codable {
        public let root: String
        public let suffixes: [String]
    }

    public enum Region: String, Codable {
        case africa = "Africa"
        case americas = "Americas"
        case antarctic = "Antarctic"
        case asia = "Asia"
        case europe = "Europe"
        case oceania = "Oceania"
    }

    public enum Status: String, Codable {
        case officially_assigned
        case user_assigned
    }

    public enum Union: String, Codable {
        case none = ""
        case eu
    }

    public struct CountryID: Codable {
        public let id: Country.ID
    }

    public struct Simple: Codable, Hashable {
        public let _id: Country.ID
        public let english: String
        public let swedish: String
        public let flag: String

        public static func none() -> Simple {
            Simple(_id: "", english: "", swedish: "", flag: "")
        }

        public struct List: Codable {
            public let items: [Simple]
        }
    }



    func simple() -> Simple {
        let translation = name.native["swe"]?.common ?? name.common
        return Country.Simple(_id: _id, english: name.common, swedish: translation, flag: flag)
    }


}



public struct Country_Simple: Codable {
    public let name_en, name_se, flag, alpha2Code, alpha3Code, numCode, region: String
    public let isEU: Bool
}
