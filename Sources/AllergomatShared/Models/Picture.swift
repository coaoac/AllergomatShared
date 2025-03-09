//
//  File.swift
//  
//
//  Created by Amine Chaouki on 2020-08-29.
//

import Foundation
public struct Picture: Codable {
    static let _cname = "Images"
    typealias ID = String
    let _id: ID
    let data: Data
    let dataType: DataType
    let dataEncoding: DataEncoding
    var user: User.ID?
    var product: Product.ID
    var updated: Date

    enum DataType: String, Codable {
        case jpeg = "image/jpeg"
        case png = "image/png"
    }

    enum DataEncoding: String, Codable {
        case base64
    }

    init(user: User.ID?, product: Product.ID, data: Data, dataType: DataType, dataEncoding: DataEncoding, updated: Date) {
        self.data = data
        self.updated = updated
        self.user = user
        self.product = product
        self.dataType = dataType
        self.dataEncoding = dataEncoding
        self._id = product + (user ?? "")
    }

    struct PictureID: Codable {
        let _id: ID
    }
}
