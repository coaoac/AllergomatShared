//
//  Errors.swift
//  App
//
//  Created by Chaouki, Amine on 2019-09-01.
//

import Foundation

public struct FError: Error, Identifiable, Codable {
    public let id: Reason
    public let source: Source
    public var code: Int = 500
    public var message: String? = nil


    public enum Source: String, Codable, Sendable {
        case server
        case app
    }

    public enum Reason: String, Codable, Sendable {
        // MARK: APP
        case no_self

        // MARK: App Store
        case app_store_error

        // MARK: Token
        case invalid_token
        case invalid_role
        case invalid_experience


        // MARK: Server User login
        case user_not_saved_to_database
        case user_not_updated_in_database
        case user_not_found_in_database
        case token_not_found_in_database
        case access_denied_to_server
        case could_not_get_public_key_from_apple
        case apple_public_key_invalid
        case could_not_convert_apple_public_key_to_data
        case could_not_create_jwt_verifier_from_apple_public_key
        case idtoken_invalid
        case user_id_does_not_match_idtoken
        case token_not_saved_to_database
        case token_not_deleted_from_database
        case could_not_convert_identity_token_to_string
        case could_not_authenticate_user
        case could_not_decode_request_content
        case correction_identical_to_existing_product
        case no_user_info
        case could_not_decode_byte_buffer
        case could_not_delete
        case could_not_update
        case invalid_app_code


        // MARK: Server Product
        case product_not_found_in_database
        case could_not_extract_categories_from_database
        case invalid_ean
        case product_not_saved
        case no_product_picture_ID
        case no_picture_found_for_product
        case no_capture_found_for_product

        case no_search_string
        case cannot_save_transaction
        case document_not_found_in_db

        // MARK: Server Allergy
        case allergy_not_found_in_database
        case ingredient_not_found_in_database
        case no_allergynames
        case no_allergens

        // MARK: Server Correction
        case missing_new_ingredient

        // MARK: Server Trasaction

        // MARK: Server Icon
        case icon_not_found_in_database

        // MARK: Sever ProductCapture
        case no_image

        // MARK: Comments
        case comment_not_found_in_database
        case cannot_save_comment

        // MARK: General
        case could_not_encode_object
        case could_not_decode_document
        case could_not_encode_or_decode_object
        case could_not_save
        case no_ok

        // MARK: APP
        case authentication_failed_with_apple
        case unsupported_authentification_mode
        case server_login_failed_with_no_data
        case application_fail
        case server_login_failed_with_error
        case cannot_save_user_to_keychain
        case server_error
        case no_data_from_server
        case cannot_decode_data
        case cannot_decode_user_data_from_keychain
        case token_expired
        case bad_URI
        case bad_http_response
        case bad_http_response_status_code
        case no_comments_for_product
        case cannot_decompress_data

    }

    public struct ServerError: Codable {
        public let error: Bool
        public let reason: Reason
    }
}

extension FError: Equatable {
    public static func == (lhs: FError, rhs: FError) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}

