//
//  Shared.swift
//  AllergiskPackageDescription
//
//  Created by Chaouki, Amine on 2019-05-12.
//

import Foundation
import Localizer
extension String {

    public init(localizedString: LocalizedString, language: Language) {
        self = localizedString.localized(language: language) ?? ""
    }

    public func upperCaseWords() -> [String] {
        var array = [String]()
        var st = ""
        for character in self {
            if character.isUppercase {
                st.append(character)
            } else {
                if st.count > 1 {
                    array.append(st)
                }
                st = ""
            }
        }
        return array
    }

    public static func random() -> String {
        return Date().description.replacingOccurrences(of: " ", with: "-") + UUID().uuidString + String(Double.random(in: 0...99999999999999995164818811802792197885196090803013355167206819763650035712))
    }

    public func rangesOf(subString: String) -> [(Int, Int)] {
        var indices = [(Int, Int)]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
            let range = self.range(of: subString, range: searchStartIndex..<self.endIndex),
            !range.isEmpty {
                let start = distance(from: self.startIndex, to: range.lowerBound)
                let end = distance(from: self.startIndex, to: range.upperBound) - 1
                indices.append((start, end))
                searchStartIndex = range.upperBound
        }

        return indices
    }
}

extension Array where Element: Hashable {
    public func uniques() -> Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

extension Date {
    public func add(days: Int) -> Date {
        self.addingTimeInterval(TimeInterval(days)*24*60*60)
    }
}

public struct CodbleWithDeletionInfo <T: Codable> {
    public let codable: T
    public let deleted: Bool
}


public struct SynchronizedSemaphore<Value> {
    private let mutex = DispatchSemaphore(value: 1)
    private var _value: Value

    init(_ value: Value) {
        self._value = value
    }

    public var value: Value {
        mutex.lock { _value }
    }

    public mutating func value(execute task: (inout Value) -> Void) {
        mutex.lock { task(&_value) }
    }
}

private extension DispatchSemaphore {

    func lock<T>(execute task: () throws -> T) rethrows -> T {
        wait()
        defer { signal() }
        return try task()
    }
}

extension Language: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Language(rawValue: rawValue) ?? .sv
    }
}



