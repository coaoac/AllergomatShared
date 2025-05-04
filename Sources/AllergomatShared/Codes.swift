//
//  Codes.swift
//  FooD-iOS
//
//  Created by Chaouki, Amine on 2019-08-07.
//

import Foundation

public struct Codes: Codable, Sendable {
    public static let appCode =
        "61cf4a5d2c498e852d4d6b899E7FC879-35D6-45DF-8587-517BC66184F42019-08-07 13:20:06 +0000"
    public static let applePublicKeyUrl = "https://appleid.apple.com/auth/keys"
    public static let userKeychainKey = "BasicUserInfo"
    public static let tokenValidity = 30
    public static let minExperience = 50
    public static let numberOfFreeProductSearchesPer30Days = 5
}
