//
//  File.swift
//  
//
//  Created by Amine Chaouki on 2020-08-29.
//

import Foundation
public struct Picture: Codable, Sendable {
    public static let _cname = "Images"
    public typealias ID = String
    public let _id: ID
    public let data: Data
    public let dataType: DataType
    public let dataEncoding: DataEncoding
    public var user: User.ID?
    public var product: Product.ID
    public var updated: Date

    enum DataType: String, Codable {
        case jpeg = "image/jpeg"
        case png = "image/png"
        case gif = "image/gif"
        case unknown = "application/octet-stream"
    }

    public enum DataEncoding: String, Codable, Sendable  {
        case base64
    }

    public init(user: User.ID?, product: Product.ID, data: Data, dataType: DataType, dataEncoding: DataEncoding, updated: Date) {
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
