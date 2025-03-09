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
        case top, read, update, insert, delete, login, logout, search, history
    }

    public enum Source: String, Codable, Sendable {
        case app, web
    }
}
