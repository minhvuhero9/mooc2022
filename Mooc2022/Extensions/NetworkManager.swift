//
//  NetworkManager.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL: String = {
        return "https://api.themoviedb.org/4"
    }()
    
    let baseURLImage: String = {
            return "https://image.tmdb.org/t/p/original"
    }()
    
    let baseURLImage500: String = {
            return "https://image.tmdb.org/t/p/w500"
    }()
}

extension NetworkManager {
    
    public func makeGetRequest<T: Decodable>(url: String,
                                             headers: HTTPHeaders?,
                                             params: Parameters?,
                                             encoding: ParameterEncoding = URLEncoding.default,
                                             completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .get,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    public func makePostRequest<T: Decodable>(url: String,
                                              headers: HTTPHeaders?,
                                              params: Parameters?,
                                              encoding: ParameterEncoding = JSONEncoding.default,
                                              completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .post,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    public func makePutRequest<T: Decodable>(url: String,
                                             headers: HTTPHeaders?,
                                             params: Parameters?,
                                             encoding: ParameterEncoding = JSONEncoding.default,
                                             completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .put,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    public func makePatchRequest<T: Decodable>(url: String,
                                               headers: HTTPHeaders?,
                                               params: Parameters?,
                                               encoding: ParameterEncoding = JSONEncoding.default,
                                               completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .patch,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    public func makeDeleteRequest<T: Decodable>(url: String,
                                                headers: HTTPHeaders?,
                                                params: Parameters?,
                                                encoding: ParameterEncoding = JSONEncoding.default,
                                                completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        self.makeRequest(url: url,
                         method: .delete,
                         headers: headers,
                         params: params,
                         encoding: encoding,
                         completion: completion)
    }
    
    private func makeRequest<T: Decodable>(url: String,
                                           method: HTTPMethod,
                                           headers: HTTPHeaders?,
                                           params: Parameters?,
                                           encoding: ParameterEncoding,
                                           completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        if ConnectionManager.shared.isConnect {
            AF.request(url,
                       method: method,
                       parameters: params,
                       encoding: encoding,
                       headers: headers,
                       interceptor: self)
                .validate()
                .responseJSON { (response) in
                    switch response.result {
                    case .success(_):
                        if let json = response.value as? [String : Any] {
                            do {
                                let data = try JSONSerialization.data(withJSONObject: json)
                                let rsp = try JSONDecoder().decode(T.self, from: data)
                                completion?(.success(rsp))
                            } catch let error {
                                completion?(.failure(NetworkError(error.asAFError)))
                            }
                        } else {
                            completion?(.failure(NetworkError()))
                        }
                    case .failure(let error):
                        completion?(.failure(NetworkError(error.asAFError)))
                    }
                }
        } else {
            completion?(.failure(NetworkError(StringConstants.networkUnavailable)))
        }
    }
    
    public func uploadImage<T: Decodable>(url:String,
                                          image: UIImage,
                                          fileName: String,
                                          method: HTTPMethod,
                                          headers: HTTPHeaders?,
                                          completion: ((Swift.Result<T, NetworkError>) -> Void)?) {
        if ConnectionManager.shared.isConnect {
            let multipartFormData: (MultipartFormData) -> Void = { formData in
                guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                    completion?(.failure(NetworkError()))
                    return
                }
                formData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/jpg")
            }
            
            AF.upload(multipartFormData: multipartFormData,
                      to: url,
                      method: method,
                      headers: headers)
                .response { (response) in
                    switch response.result {
                    case .success(let result):
                        if let data = result {
                            do {
                                let rsp = try JSONDecoder().decode(T.self, from: data)
                                completion?(.success(rsp))
                            } catch let error {
                                completion?(.failure(NetworkError(error.asAFError)))
                            }
                        } else {
                            completion?(.failure(NetworkError()))
                        }
                    case .failure(let error):
                        completion?(.failure(NetworkError(error.asAFError)))
                    }
                }
        } else {
            completion?(.failure(NetworkError(StringConstants.networkUnavailable)))
        }
    }
    
}

extension NetworkManager: RequestInterceptor {
    
//    internal func adapt(_ urlRequest: URLRequest,
//                        for session: Session,
//                        completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        var request = urlRequest
//        guard let token = KeychainManager.apiIdToken() else {
//            completion(.success(urlRequest))
//            return
//        }
//        let bearerToken = "Bearer \(token)"
//        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
//        print("\nadapted; token added to the header field is: \(bearerToken)\n")
//        completion(.success(request))
//    }
    
    internal func retry(_ request: Request,
                        for session: Session,
                        dueTo error: Error,
                        completion: @escaping (RetryResult) -> Void) {
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        guard request.retryCount < 3 else {
            completion(.doNotRetry)
            return
        }
        
        print("Retry \(request.retryCount) time with statusCode....\(statusCode)")
        
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        case 401, 403:
            completion(.doNotRetry)
        default:
            completion(.doNotRetry)
        }
    }
    
}

class NetworkError: Error {
    
    var message = ""
    
    init(_ error: AFError?) {
        if let error = error {
            switch error.responseCode {
            case 401:
                self.message = StringConstants.ERROR_CODE_401
            case 404:
                self.message = StringConstants.ERROR_CODE_404
            case 500:
                self.message = StringConstants.ERROR_CODE_500
            default:
                self.message = error.localizedDescription
            }
        } else {
            self.message = StringConstants.ERROR_CODE_COMMON
        }
    }
    
    init(_ message: String = StringConstants.ERROR_CODE_COMMON) {
        self.message = message
    }
    
}

