//
//  Authentication.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation

struct Authentication {
    let success: Bool
    let statusMessage: String
    let requestToken: String
    let statusCode: Int
}

extension Authentication: Decodable {
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case statusMessage = "status_message"
        case requestToken = "request_token"
        case statusCode = "status_code"
    }
}
