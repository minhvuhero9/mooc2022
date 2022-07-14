//
//  LoginViewModel.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation

class LoginViewModel: NSObject {
    
    // MARK: - Properties
    var loginSuccess: () -> Void = {}
    var fetchDataFailure: (String) -> Void = { _ in }
    
}

// MARK: - Methods
extension LoginViewModel {
    func createRequestToken() {
        NetworkManager.shared.createNewToken { [weak self] result in
            switch result {
            case.success(let authen):
                print(authen)
                StringConstants.requestToken = authen.requestToken
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func login() {
        createRequestToken()
    }
}
