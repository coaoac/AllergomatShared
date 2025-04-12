import Foundation
import Localizer

/// Centralized service for handling language, country and localization functionality
public struct LocalizationService {
    
    // MARK: - Language Codes
    
    /// Maps a Language enum to an ISO 639-1 two-letter language code
    /// - Parameter language: The language to convert
    /// - Returns: The ISO 639-1 language code
    public static func isoCode(for language: Language) -> String {
        return language.rawValue
    }
    
    /// Returns a default language preference order
    /// - Returns: Array of languages in preferred order
    public static func defaultLanguagePreference() -> [Language] {
        return [.sv, .en]
    }
/*
    // MARK: - Country Codes


    /// Returns the country code associated with a language
    /// - Parameter language: The language to get the country code for
    /// - Returns: The two-letter ISO 3166-1 alpha-2 country code
    public static func countryCode(for language: Language) -> String {
        switch language {
        case .en: return "GB"
        case .sv: return "SE"
        case .de: return "DE"
        case .fr: return "FR"
        case .it: return "IT"
        case .es: return "ES"
        case .pt: return "PT"
        case .nl: return "NL"
        case .pl: return "PL"
        case .dk: return "DK"
        case .no: return "NO"
        case .ru: return "RU"
        case .jp: return "JP"
        case .kr: return "KR"
        case .cn: return "CN"
        case .ae: return "AE"
        case .tr: return "TR"
        case .gr: return "GR"
        case .il: return "IL"
        case .cz: return "CZ"
        case .hu: return "HU"
        case .ro: return "RO"
        case .bg: return "BG"
        case .ua: return "UA"
        case .th: return "TH"
        case .vn: return "VN"
        case .id: return "ID"
        case .my: return "MY"
        case .rs: return "RS"
        }
    }
    
    // MARK: - Locale Formatting
    
    /// Gets the locale string for a language (language code + country code)
    /// - Parameter language: The language to get the locale for
    /// - Returns: The locale string in format "xx-XX"
    public static func locale(for language: Language) -> String {
        let langCode = isoCode(for: language)
        let countryCode = self.countryCode(for: language)
        return "\(langCode)-\(countryCode)"
    }
    
    /// Gets market and locale tuple based on language
    /// - Parameter language: The language to get market and locale for
    /// - Returns: A tuple with market (country code) and locale string
    public static func getMarketAndLocale(for language: Language) -> (market: String, locale: String) {
        let market = countryCode(for: language)
        let locale = self.locale(for: language)
        return (market, locale)
    }
    
    // MARK: - Localized String Helpers
    
    /// Get the primary and fallback languages from a provided list
    public static func getPrimaryAndFallback(from languages: [Language]) -> (primary: Language, fallback: Language?) {
        let defaultLanguages = [Language.sv, Language.en]
        let availableLanguages = languages.isEmpty ? defaultLanguages : languages
        
        // Primary is Swedish if available, otherwise the first language
        let primary = availableLanguages.contains(.sv) ? .sv : availableLanguages[0]
        
        // Fallback is English if available and not the primary, otherwise the second language if exists
        let fallback: Language?
        if primary != .en && availableLanguages.contains(.en) {
            fallback = .en
        } else if availableLanguages.count > 1 && availableLanguages[0] != availableLanguages[1] {
            fallback = availableLanguages[1]
        } else {
            fallback = nil
        }
        
        return (primary, fallback)
    }
    
    /// Get the best available localized string from a map based on preferred languages
    public static func getBestLocalizedString(
        from localizedStrings: [Language: String],
        preferredLanguages: [Language] = defaultLanguagePreference()
    ) -> String? {
        for language in preferredLanguages {
            if let value = localizedStrings[language], !value.isEmpty {
                return value
            }
        }
        
        // If none of the preferred languages are found, return the first non-empty value
        return localizedStrings.values.first(where: { !$0.isEmpty })
    }
    
    /// Create a structured `LocalizedString` based on available content
    public static func createLocalizedString(
        swedish: String?,
        english: String?,
        fallback: String? = nil
    ) -> LocalizedString {
        var localizedStrings = [Language: String]()
        
        if let swedish = swedish, !swedish.isEmpty {
            localizedStrings[.sv] = swedish
        }
        
        if let english = english, !english.isEmpty {
            localizedStrings[.en] = english
        }
        
        // If neither is available but we have a fallback, use it for both
        if localizedStrings.isEmpty, let fallback = fallback, !fallback.isEmpty {
            localizedStrings[.sv] = fallback
            localizedStrings[.en] = fallback
        }
        
        return LocalizedString(en: english, sv: swedish)
    }
    */
    // MARK: - Country Name Mapping
    
    /// Maps a country name to ISO 3166-1 alpha-2 code
    /// - Parameter countryText: The country name to map
    /// - Returns: ISO country code if recognized
    public static func mapCountryToISOCode(_ countryText: String) -> String? {
        let text = countryText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        return CountryCodeMapper.mapCountryToCode(text)
    }
}

// MARK: - Country Code Mapping Helper

/// Helper enum for mapping country names to ISO codes
private enum CountryCodeMapper {
    
    /// Maps a country name to its ISO 3166-1 alpha-2 code
    /// - Parameter text: Lowercased country name text
    /// - Returns: ISO country code if recognized
    static func mapCountryToCode(_ text: String) -> String? {
        // Europe
        if text.contains("albania") { return "AL" }
        if text.contains("andorra") { return "AD" }
        if text.contains("austria") || text.contains("österreich") { return "AT" }
        if text.contains("belarus") { return "BY" }
        if text.contains("belgium") || text.contains("belgien") { return "BE" }
        if text.contains("bosnia") || text.contains("herzegovina") { return "BA" }
        if text.contains("bulgaria") { return "BG" }
        if text.contains("croatia") { return "HR" }
        if text.contains("cyprus") { return "CY" }
        if text.contains("czech") || text.contains("česká") { return "CZ" }
        if text.contains("denmark") || text.contains("danmark") { return "DK" }
        if text.contains("estonia") { return "EE" }
        if text.contains("finland") { return "FI" }
        if text.contains("france") || text.contains("frankrike") { return "FR" }
        if text.contains("germany") || text.contains("deutschland") { return "DE" }
        if text.contains("greece") || text.contains("elláda") { return "GR" }
        if text.contains("hungary") || text.contains("magyarország") { return "HU" }
        if text.contains("iceland") || text.contains("ísland") { return "IS" }
        if text.contains("ireland") { return "IE" }
        if text.contains("italy") || text.contains("italien") { return "IT" }
        if text.contains("kosovo") { return "XK" }
        if text.contains("latvia") { return "LV" }
        if text.contains("liechtenstein") { return "LI" }
        if text.contains("lithuania") { return "LT" }
        if text.contains("luxembourg") { return "LU" }
        if text.contains("macedonia") { return "MK" }
        if text.contains("malta") { return "MT" }
        if text.contains("moldova") { return "MD" }
        if text.contains("monaco") { return "MC" }
        if text.contains("montenegro") { return "ME" }
        if text.contains("netherlands") || text.contains("holland")
            || text.contains("nederländerna")
        {
            return "NL"
        }
        if text.contains("norway") || text.contains("norge") { return "NO" }
        if text.contains("poland") || text.contains("polska") { return "PL" }
        if text.contains("portugal") { return "PT" }
        if text.contains("romania") { return "RO" }
        if text.contains("russia") || text.contains("russian") { return "RU" }
        if text.contains("serbia") { return "RS" }
        if text.contains("slovakia") { return "SK" }
        if text.contains("slovenia") { return "SI" }
        if text.contains("spain") || text.contains("españa") || text.contains("spanien") {
            return "ES"
        }
        if text.contains("sweden") || text.contains("sverige") { return "SE" }
        if text.contains("switzerland") || text.contains("schweiz") { return "CH" }
        if text.contains("turkey") || text.contains("türkiye") { return "TR" }
        if text.contains("ukraine") { return "UA" }
        if text.contains("uk") || text.contains("united kingdom") || text.contains("great britain")
        {
            return "GB"
        }
        
        // Africa
        if text.contains("algeria") { return "DZ" }
        if text.contains("angola") { return "AO" }
        if text.contains("benin") { return "BJ" }
        if text.contains("botswana") { return "BW" }
        if text.contains("burkina faso") { return "BF" }
        if text.contains("burundi") { return "BI" }
        if text.contains("cape verde") || text.contains("cabo verde") { return "CV" }
        if text.contains("cameroon") { return "CM" }
        if text.contains("central african republic") { return "CF" }
        if text.contains("chad") { return "TD" }
        if text.contains("comoros") { return "KM" }
        if text.contains("congo") { return "CG" }
        if text.contains("djibouti") { return "DJ" }
        if text.contains("egypt") { return "EG" }
        if text.contains("equatorial guinea") { return "GQ" }
        if text.contains("eritrea") { return "ER" }
        if text.contains("ethiopia") { return "ET" }
        if text.contains("gabon") { return "GA" }
        if text.contains("gambia") { return "GM" }
        if text.contains("ghana") { return "GH" }
        if text.contains("guinea") { return "GN" }
        if text.contains("guinea-bissau") { return "GW" }
        if text.contains("kenya") { return "KE" }
        if text.contains("lesotho") { return "LS" }
        if text.contains("liberia") { return "LR" }
        if text.contains("libya") { return "LY" }
        if text.contains("madagascar") { return "MG" }
        if text.contains("malawi") { return "MW" }
        if text.contains("mali") { return "ML" }
        if text.contains("mauritania") { return "MR" }
        if text.contains("mauritius") { return "MU" }
        if text.contains("morocco") || text.contains("maroc") { return "MA" }
        if text.contains("mozambique") { return "MZ" }
        if text.contains("namibia") { return "NA" }
        if text.contains("niger") { return "NE" }
        if text.contains("nigeria") { return "NG" }
        if text.contains("rwanda") { return "RW" }
        if text.contains("saint helena") { return "SH" }
        if text.contains("sao tome") || text.contains("principe") { return "ST" }
        if text.contains("senegal") { return "SN" }
        if text.contains("seychelles") { return "SC" }
        if text.contains("sierra leone") { return "SL" }
        if text.contains("somalia") { return "SO" }
        if text.contains("south africa") { return "ZA" }
        if text.contains("south sudan") { return "SS" }
        if text.contains("sudan") { return "SD" }
        if text.contains("swaziland") { return "SZ" }
        if text.contains("tanzania") { return "TZ" }
        if text.contains("togo") { return "TG" }
        if text.contains("tunisia") { return "TN" }
        if text.contains("uganda") { return "UG" }
        if text.contains("zambia") { return "ZM" }
        if text.contains("zimbabwe") { return "ZW" }
        
        // Asia
        if text.contains("afghanistan") { return "AF" }
        if text.contains("armenia") { return "AM" }
        if text.contains("azerbaijan") { return "AZ" }
        if text.contains("bangladesh") { return "BD" }
        if text.contains("bhutan") { return "BT" }
        if text.contains("brunei") { return "BN" }
        if text.contains("cambodia") { return "KH" }
        if text.contains("china") || text.contains("kina") { return "CN" }
        if text.contains("india") || text.contains("indien") { return "IN" }
        if text.contains("indonesia") { return "ID" }
        if text.contains("iran") { return "IR" }
        if text.contains("iraq") { return "IQ" }
        if text.contains("israel") { return "IL" }
        if text.contains("japan") { return "JP" }
        if text.contains("jordan") { return "JO" }
        if text.contains("kazakhstan") { return "KZ" }
        if text.contains("kuwait") { return "KW" }
        if text.contains("kyrgyzstan") { return "KG" }
        if text.contains("laos") { return "LA" }
        if text.contains("lebanon") { return "LB" }
        if text.contains("malaysia") { return "MY" }
        if text.contains("maldives") { return "MV" }
        if text.contains("mongolia") { return "MN" }
        if text.contains("myanmar") || text.contains("burma") { return "MM" }
        if text.contains("nepal") { return "NP" }
        if text.contains("north korea") { return "KP" }
        if text.contains("oman") { return "OM" }
        if text.contains("pakistan") { return "PK" }
        if text.contains("palestine") { return "PS" }
        if text.contains("philippines") { return "PH" }
        if text.contains("qatar") { return "QA" }
        if text.contains("saudi arabia") { return "SA" }
        if text.contains("singapore") { return "SG" }
        if text.contains("south korea") { return "KR" }
        if text.contains("sri lanka") { return "LK" }
        if text.contains("syria") { return "SY" }
        if text.contains("taiwan") { return "TW" }
        if text.contains("tajikistan") { return "TJ" }
        if text.contains("thailand") { return "TH" }
        if text.contains("timor-leste") { return "TL" }
        if text.contains("turkmenistan") { return "TM" }
        if text.contains("united arab emirates") { return "AE" }
        if text.contains("uzbekistan") { return "UZ" }
        if text.contains("vietnam") { return "VN" }
        if text.contains("yemen") { return "YE" }
        
        // North America
        if text.contains("antigua") || text.contains("barbuda") { return "AG" }
        if text.contains("bahamas") { return "BS" }
        if text.contains("barbados") { return "BB" }
        if text.contains("belize") { return "BZ" }
        if text.contains("canada") { return "CA" }
        if text.contains("costa rica") { return "CR" }
        if text.contains("cuba") { return "CU" }
        if text.contains("dominica") { return "DM" }
        if text.contains("dominican republic") { return "DO" }
        if text.contains("el salvador") { return "SV" }
        if text.contains("grenada") { return "GD" }
        if text.contains("guatemala") { return "GT" }
        if text.contains("haiti") { return "HT" }
        if text.contains("honduras") { return "HN" }
        if text.contains("jamaica") { return "JM" }
        if text.contains("mexico") { return "MX" }
        if text.contains("nicaragua") { return "NI" }
        if text.contains("panama") { return "PA" }
        if text.contains("saint kitts") || text.contains("nevis") { return "KN" }
        if text.contains("saint lucia") { return "LC" }
        if text.contains("saint vincent") || text.contains("grenadines") { return "VC" }
        if text.contains("trinidad") || text.contains("tobago") { return "TT" }
        if text.contains("usa") || text.contains("united states") || text.contains("america") {
            return "US"
        }
        
        // South America
        if text.contains("argentina") { return "AR" }
        if text.contains("bolivia") { return "BO" }
        if text.contains("brazil") || text.contains("brasil") { return "BR" }
        if text.contains("chile") { return "CL" }
        if text.contains("colombia") { return "CO" }
        if text.contains("ecuador") { return "EC" }
        if text.contains("french guiana") { return "GF" }
        if text.contains("guyana") { return "GY" }
        if text.contains("paraguay") { return "PY" }
        if text.contains("peru") { return "PE" }
        if text.contains("suriname") { return "SR" }
        if text.contains("uruguay") { return "UY" }
        if text.contains("venezuela") { return "VE" }
        
        // Oceania
        if text.contains("australia") { return "AU" }
        if text.contains("fiji") { return "FJ" }
        if text.contains("kiribati") { return "KI" }
        if text.contains("marshall islands") { return "MH" }
        if text.contains("micronesia") { return "FM" }
        if text.contains("nauru") { return "NR" }
        if text.contains("new zealand") { return "NZ" }
        if text.contains("palau") { return "PW" }
        if text.contains("papua new guinea") { return "PG" }
        if text.contains("samoa") { return "WS" }
        if text.contains("solomon islands") { return "SB" }
        if text.contains("tonga") { return "TO" }
        if text.contains("tuvalu") { return "TV" }
        if text.contains("vanuatu") { return "VU" }

        return nil
    }
}
