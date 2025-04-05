import Foundation

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
        return [.swedish, .english, .german, .french]
    }
    
    // MARK: - Country Codes
    
    /// Returns the country code associated with a language
    /// - Parameter language: The language to get the country code for
    /// - Returns: The two-letter ISO 3166-1 alpha-2 country code
    public static func countryCode(for language: Language) -> String {
        switch language {
        case .english: return "GB"
        case .swedish: return "SE"
        case .german: return "DE"
        case .french: return "FR"
        case .italian: return "IT"
        case .spanish: return "ES"
        case .portuguese: return "PT"
        case .dutch: return "NL"
        case .polish: return "PL"
        case .danish: return "DK"
        case .norwegian: return "NO"
        case .russian: return "RU"
        case .japanese: return "JP"
        case .korean: return "KR"
        case .chinese: return "CN"
        case .arabic: return "AE"
        case .turkish: return "TR"
        case .greek: return "GR"
        case .hebrew: return "IL"
        case .czech: return "CZ"
        case .hungarian: return "HU"
        case .romanian: return "RO"
        case .bulgarian: return "BG"
        case .ukrainian: return "UA"
        case .thai: return "TH"
        case .vietnamese: return "VN"
        case .indonesian: return "ID"
        case .malay: return "MY"
        case .serbian: return "RS"
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
        let defaultLanguages = [Language.swedish, Language.english]
        let availableLanguages = languages.isEmpty ? defaultLanguages : languages
        
        // Primary is Swedish if available, otherwise the first language
        let primary = availableLanguages.contains(Language.swedish) ? Language.swedish : availableLanguages[0]
        
        // Fallback is English if available and not the primary, otherwise the second language if exists
        let fallback: Language?
        if primary != Language.english && availableLanguages.contains(Language.english) {
            fallback = Language.english
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
        preferredLanguages: [Language] = [Language.swedish, Language.english]
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
            localizedStrings[.swedish] = swedish
        }
        
        if let english = english, !english.isEmpty {
            localizedStrings[.english] = english
        }
        
        // If neither is available but we have a fallback, use it for both
        if localizedStrings.isEmpty, let fallback = fallback, !fallback.isEmpty {
            localizedStrings[.swedish] = fallback
            localizedStrings[.english] = fallback
        }
        
        return LocalizedString(localizations: localizedStrings)
    }
    
    // MARK: - Country Name Mapping
    
    /// Maps a country name to ISO 3166-1 alpha-2 code
    /// - Parameter countryText: The country name to map
    /// - Returns: ISO country code if recognized
    public static func mapCountryToISOCode(_ countryText: String) -> String? {
        let text = countryText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
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
        
        // North America
        if text.contains("canada") { return "CA" }
        if text.contains("mexico") { return "MX" }
        if text.contains("usa") || text.contains("united states") || text.contains("america") {
            return "US"
        }
        
        // Asia
        if text.contains("china") || text.contains("kina") { return "CN" }
        if text.contains("japan") { return "JP" }
        if text.contains("india") || text.contains("indien") { return "IN" }
        if text.contains("south korea") { return "KR" }
        if text.contains("thailand") { return "TH" }
        
        // Other common countries
        if text.contains("australia") { return "AU" }
        if text.contains("brazil") || text.contains("brasil") { return "BR" }
        if text.contains("new zealand") { return "NZ" }
        
        // For a more comprehensive implementation, add more countries as needed
        return nil
    }
}