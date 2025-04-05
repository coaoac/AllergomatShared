//
//  Transaction.swift
//  AllergomatShared
//
//  Created by Amine Chaouki on 2025-03-09.
//

import Foundation

public struct Transaction: Codable, Sendable {
    public static let _cname = "Transactions"
    public typealias ID = String
    public let _id: ID
    public let userID: String?
    public let country: String?
    public let userAgent: String?
    public let collection: String
    public let item: String?
    public let nature: Nature
    public let time: Date
    public let source: Source
    
    public enum Nature: String, Codable, Sendable {
        case top, read, update, insert, delete, login, logout, search, history, ai
    }

    public enum Source: String, Codable, Sendable {
        case app, web, server
    }
    
    public init(_id: ID, userID: String?, country: String?, userAgent: String?, collection: String, item: String?, nature: Nature, time: Date, source: Source) {
        self._id = _id
        self.userID = userID
        self.country = country
        self.userAgent = userAgent
        self.collection = collection
        self.item = item
        self.nature = nature
        self.time = time
        self.source = source
    }
}
