//
//  Country.swift
//  AllergiskPackageDescription
//
//  Created by Chaouki, Amine on 2019-01-12.
//

import Foundation

public struct Country: Codable, Sendable {
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

    public init(_id: ID, name: Name, tld: [String], ccn3: String, cca3: String, cioc: String, independent: Bool?, status: Status, currencies: [String: Currency], idd: Idd, capital: [String], altSpellings: [String], region: Region, subregion: String, languages: [String: String], translations: [String: Translation], latlng: [Double], demonym: String, landlocked: Bool, borders: [String], area: Double, flag: String, union: Union, unionflag: String) {
        self._id = _id
        self.name = name
        self.tld = tld
        self.ccn3 = ccn3
        self.cca3 = cca3
        self.cioc = cioc
        self.independent = independent
        self.status = status
        self.currencies = currencies
        self.idd = idd
        self.capital = capital
        self.altSpellings = altSpellings
        self.region = region
        self.subregion = subregion
        self.languages = languages
        self.translations = translations
        self.latlng = latlng
        self.demonym = demonym
        self.landlocked = landlocked
        self.borders = borders
        self.area = area
        self.flag = flag
        self.union = union
        self.unionflag = unionflag
    }

    // MARK: Name
    public struct Name: Codable, Sendable {
        public let common: String
        public let official: String
        public let native: [String: Translation]

        public init(common: String, official: String, native: [String: Translation]) {
            self.common = common
            self.official = official
            self.native = native
        }
    }

    // MARK: Translation
    public struct Translation: Codable, Sendable {
        public let official: String
        public let common: String

        public init(official: String, common: String) {
            self.official = official
            self.common = common
        }
    }

    // MARK: Currency
    public struct Currency: Codable, Sendable {
        public let name: String
        public let symbol: String

        public init(name: String, symbol: String) {
            self.name = name
            self.symbol = symbol
        }
    }

    // MARK: Idd
    public struct Idd: Codable, Sendable {
        public let root: String
        public let suffixes: [String]

        public init(root: String, suffixes: [String]) {
            self.root = root
            self.suffixes = suffixes
        }
    }

    public enum Region: String, Codable, Sendable {
        case africa = "Africa"
        case americas = "Americas"
        case antarctic = "Antarctic"
        case asia = "Asia"
        case europe = "Europe"
        case oceania = "Oceania"
    }

    public enum Status: String, Codable, Sendable {
        case officially_assigned
        case user_assigned
    }

    public enum Union: String, Codable, Sendable {
        case none = ""
        case eu
    }

    public struct CountryID: Codable, Sendable {
        public let id: Country.ID

        public init(id: Country.ID) {
            self.id = id
        }
    }

    public struct Simple: Codable, Hashable, Sendable {
        public let _id: Country.ID
        public let english: String
        public let swedish: String
        public let flag: String

        public init(_id: Country.ID, english: String, swedish: String, flag: String) {
            self._id = _id
            self.english = english
            self.swedish = swedish
            self.flag = flag
        }

        public static func none() -> Simple {
            Simple(_id: "", english: "", swedish: "", flag: "")
        }

        public struct List: Codable, Sendable {
            public let items: [Simple]

            public init(items: [Simple]) {
                self.items = items
            }
        }
    }
    
    public func simple() -> Simple {
        let translation = name.native["swe"]?.common ?? name.common
        return Country.Simple(_id: _id, english: name.common, swedish: translation, flag: flag)
    }


}

public struct Country_Simple: Codable, Sendable, Identifiable {
    public let name_en, name_se, flag, alpha2Code, alpha3Code, numCode, region: String
    public let isEU: Bool
    public var id: Country.ID {
        alpha2Code
    }

    public init(name_en: String, name_se: String, flag: String, alpha2Code: String, alpha3Code: String, numCode: String, region: String, isEU: Bool) {
        self.name_en = name_en
        self.name_se = name_se
        self.flag = flag
        self.alpha2Code = alpha2Code
        self.alpha3Code = alpha3Code
        self.numCode = numCode
        self.region = region
        self.isEU = isEU
    }
}
