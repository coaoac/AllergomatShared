//
//  Shared.swift
//  AllergiskPackageDescription
//
//  Created by Chaouki, Amine on 2019-05-12.
//

import Foundation

extension String {

    func upperCaseWords() -> [String] {
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

    static func random() -> String {
        return Date().description.replacingOccurrences(of: " ", with: "-") + UUID().uuidString + String(Double.random(in: 0...99999999999999995164818811802792197885196090803013355167206819763650035712))
    }

    func rangesOf(subString: String) -> [(Int, Int)] {
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
    func uniques() -> Array {
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
    func add(days: Int) -> Date {
        self.addingTimeInterval(TimeInterval(days)*24*60*60)
    }
}

struct CodbleWithDeletionInfo <T: Codable> {
    let codable: T
    let deleted: Bool
}


struct SynchronizedSemaphore<Value> {
    private let mutex = DispatchSemaphore(value: 1)
    private var _value: Value

    init(_ value: Value) {
        self._value = value
    }

    var value: Value {
        mutex.lock { _value }
    }

    mutating func value(execute task: (inout Value) -> Void) {
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





