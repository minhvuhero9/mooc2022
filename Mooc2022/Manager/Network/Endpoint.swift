//
//  Endpoint.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation

// MARK: - Authentication
public struct Endpoint {
    static let auth = "/auth/request_token"
    static let session = "/authentication/session/new"
}

// MARK: - Movies
extension Endpoint {
    static let listMovie = "/list/1"
}

