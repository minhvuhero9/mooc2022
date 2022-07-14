//
//  AuthencationManager.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation
import Alamofire

extension NetworkManager {
    public func createNewToken(completion: ((Swift.Result<Authentication, NetworkError>) -> Void)? = nil) {
        let authorization = StringConstants.accessToken
        let params = [
            "api_key": StringConstants.apiKey,
            "redirect_to": "http://www.themoviedb.org/"
        ] as [String : Any]

        let headers: HTTPHeaders = [.authorization(bearerToken: authorization)]
        self.makePostRequest(url: self.baseURL + Endpoint.listMovie,
                             headers: headers,
                             params: params,
                             completion: completion)
    }
}
