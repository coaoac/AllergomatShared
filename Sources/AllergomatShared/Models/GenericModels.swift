//
//  GenericModels.swift
//  FooD
//
//  Created by Chaouki, Amine on 2019-10-07.
//

import Foundation
import Localizer

// Enumération pour les langues supportées
/*
public enum Language: String, Codable, Sendable, CaseIterable {
    case english = "en" // 1st default
    case swedish = "sv" // 2st default
    case french = "fr" // 3rd default
    case german = "de"
    case italian = "it"
    case dutch = "nl"
    case polish = "pl"
    case portuguese = "pt"
    case spanish = "es"
    case danish = "da"
    case norwegian = "no"
    case turkish = "tr"
    case hungarian = "hu"
    case romanian = "ro"
    case bulgarian = "bg"
    case czech = "cs"
    case greek = "el"
    case japanese = "ja"
    case korean = "ko"
    case malay = "ms"
    case thai = "th"
    case vietnamese = "vi"
    case arabic = "ar"
    case hebrew = "he"
    case indonesian = "id"
    case russian = "ru"
    case serbian = "sr"
    case ukrainian = "uk"
    case chinese = "zh"

    // Pour obtenir le nom de la langue en format lisible
    public func displayName() -> String {
        switch self {
        case .english: return "English"
        case .swedish: return "Swedish"
        case .french: return "French"
        case .german: return "German"
        case .italian: return "Italian"
        case .dutch: return "Dutch"
        case .polish: return "Polish"
        case .portuguese: return "Portuguese"
        case .spanish: return "Spanish" 
        case .danish: return "Danish"  
        case .norwegian: return "Norwegian"
        case .turkish: return "Turkish"
        case .hungarian: return "Hungarian"
        case .romanian: return "Romanian"
        case .bulgarian: return "Bulgarian"
        case .czech: return "Czech"
        case .greek: return "Greek"
        case .japanese: return "Japanese"
        case .korean: return "Korean"
        case .malay: return "Malay"
        case .thai: return "Thai"
        case .vietnamese: return "Vietnamese"
        case .arabic: return "Arabic"
        case .hebrew: return "Hebrew"
        case .indonesian: return "Indonesian"
        case .russian: return "Russian"
        case .serbian: return "Serbian"
        case .ukrainian: return "Ukrainian"
        case .chinese: return "Chinese"
        }
    }
    
    public static func defaultLanguage() -> Language {
        return .english
    }
}

public struct LocalizedString: Codable, Hashable, Sendable {
    public var en: String?
    public var sv: String?
    

    public init(en: String?, sv: String?) {
        self.en = en
        self.sv = sv
    }

    public func localized(language: Language) -> String? {
        switch language {
        case .en: return en
        case .sv: return sv
        default: return nil
        }
    }
}
*/

public struct OK: Codable, Sendable {
    public let ok: Bool

    public init(_ ok: Bool) {
        self.ok = ok
    }
}

public enum Proba: String, Codable, Comparable, Hashable, Sendable {
    public static func < (lhs: Proba, rhs: Proba) -> Bool {
        Proba.all().firstIndex(of: lhs) ?? 0 < Proba.all().firstIndex(of: rhs) ?? 0
    }

    public func english() -> String {
        switch self {
        case .none: return "No risk"
        case .low: return "Low risk"
        case .medium: return "Medium risk"
        case .high: return "High risk!"
        }
    }

    public func swedish() -> String {
        switch self {
        case .none: return "Ingen risk"
        case .low: return "Låg risk"
        case .medium: return "Medelhög risk"
        case .high: return "Hög risk!"
        }
    }

    static func all() -> [Self] {
        return [.none, .low, .medium, .high]
    }

    case low, medium, high, none
}

public enum Status: Int, Codable, Comparable, Sendable, Identifiable {
    public var id: Int {
        rawValue
    }

    case approved = 8  //computed
    case rejected = 7  //computed

    case reviewed = 6
    case sent = 5
    case sending = 4
    case local = 3
    case error = 2
    case delete = 1
    case none = 0

    public static func all() -> [Status] {
        [.none, .delete, .error, .local, .sending, .sent, .reviewed, .rejected, .approved]
    }

    public func english(short: Bool) -> String {
        switch self {
        case .approved: return short ? "approved" : "Your input was approved!"
        case .rejected:
            return short ? "rejected" : "Your input contained errors it was corrected by our team"
        case .reviewed: return short ? "reviewed!" : "Your input has been reviewed!"
        case .sent:
            return short ? "sent" : "Your input is submitted but not yet reviewed by our team."
        case .sending: return short ? "sending..." : "Your input is being sent to our servers..."
        case .local: return short ? "local" : "Your input is saved locally"
        case .error: return short ? "error!" : "An error happened. Try again..."
        case .delete: return short ? "reset" : "To reset"
        case .none: return ""
        }
    }

    public func swedish(short: Bool) -> String {
        switch self {
        case .approved: return short ? "godkänd!" : "Din input har godkänts!"
        case .rejected: return short ? "nekad" : "Din input var fel. Det korrigerades av vårt team."
        case .reviewed: return short ? "granskat" : "Din input var granskats."
        case .sent: return short ? "skickad" : "Din input har skickats men har inte än gränskats."
        case .sending: return short ? "skickas..." : "Din inout skickas..."
        case .local: return short ? "lokalt" : "Din inout har sparats lokalt..."
        case .error: return short ? "fel" : "Något gick fel. Försök igen..."
        case .delete: return short ? "återställ" : "Att återställa"
        case .none: return ""
        }
    }

    public static func < (lhs: Status, rhs: Status) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public func noReviewedStatus(same: Bool) -> Status {
        if self == .reviewed {
            if same {
                return .approved
            } else {
                return .rejected
            }
        } else {
            return self
        }
    }
}

public struct Settings: Codable, Sendable {
    public let userInfo: User.BasicUserInfo
    public let supportedAllergies: [Allergy]
    public let numberOfProducts: Int
    public let numberOfProductSearchesLast30Days: Int

    public init(
        userInfo: User.BasicUserInfo, supportedAllergies: [Allergy], numberOfProducts: Int,
        numberOfProductSearchesLast30Days: Int
    ) {
        self.userInfo = userInfo
        self.supportedAllergies = supportedAllergies
        self.numberOfProducts = numberOfProducts
        self.numberOfProductSearchesLast30Days = numberOfProductSearchesLast30Days
    }
}
