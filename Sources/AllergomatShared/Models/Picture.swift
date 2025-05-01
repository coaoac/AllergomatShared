//
//  File.swift
//
//
//  Created by Amine Chaouki on 2020-08-29.
//

import Foundation
import Localizer

public struct Picture: Codable, Sendable {
    public static let _cname = "Images"
    public typealias ID = String
    public let _id: ID
    public let data: Data
    public let dataType: Data.Format
    public let dataEncoding: Data.Encoding
    public var user: User.ID?
    public var product: Product.ID
    public var updated: Date

    public init(
        user: User.ID?, product: Product.ID, data: Data, dataType: Data.Format,
        dataEncoding: Data.Encoding, updated: Date
    ) {
        self.data = data
        self.updated = updated
        self.user = user
        self.product = product
        self.dataType = dataType
        self.dataEncoding = dataEncoding
        self._id = product + (user ?? "")
    }

    public struct PictureID: Codable, Sendable {
        public let _id: ID
        public init(from _id: ID) {
            self._id = _id
        }
    }
}
