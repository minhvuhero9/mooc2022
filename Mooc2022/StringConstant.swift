//
//  StringConstant.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation

// MARK: - URLs
public struct StringConstants {
    static let apiKey = "8a393e8d60e1bdf80d8598e424155ea0"
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YTM5M2U4ZDYwZTFiZGY4MGQ4NTk4ZTQyNDE1NWVhMCIsInN1YiI6IjYyYzVlYWUyOTU2NjU4MDA0YzY2OTY4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.r2heHC5nEg_ggUpvCKl3T9zeXhrZu4HaNUluFgLTP04"
    static var requestToken = ""
}
// MARK: - Network error message
extension StringConstants {
    static let ERROR_CODE_COMMON = "Network Error",
               ERROR_CODE_401 = "Invalid API key: You must be granted a valid key.",
               ERROR_CODE_404 = "The resource you requested could not be found.",
               ERROR_CODE_500 = "Internal error: Something went wrong, contact TMDb."
}

// MARK: - Internet
extension StringConstants {
    static let internetMessageDisconnected = "internet_message_disconnected",
               networkUnavailable = "internet_network_unavailable"
}
