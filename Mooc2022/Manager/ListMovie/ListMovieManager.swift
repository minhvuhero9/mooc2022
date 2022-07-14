//
//  ListMovieManager.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation
import Alamofire

extension NetworkManager {
    public func getListMovie(completion: ((Swift.Result<ListMovieModel, NetworkError>) -> Void)? = nil) {
        let authorization = StringConstants.accessToken
        let headers: HTTPHeaders = [.authorization(bearerToken: authorization)]
        self.makeGetRequest(url: self.baseURL + Endpoint.listMovie,
                             headers: headers,
                             params: nil,
                             completion: completion)
    }
    
    
}
