//
//  LoginService.swift
//  Mooc2022
//
//  Created by Trieu Le on 26/07/2022.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class LoginService {
    
    enum LoginType: String {
        case google
        case facebook
        case apple
    }
    
    static let shared = LoginService()
    
    var currentUser: User? {
        get {
            return Auth.auth().currentUser
        }
    }
    
    func loginWithGoogle(vc: UIViewController, onSuccess: @escaping () -> Void, onFailed: @escaping (Error?) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [weak self] user, error in
            if let err = error {
                if (err as NSError).code == -5 {
                    Log.debug.out("The user canceled the sign-in flow.")
                    return
                }
                onFailed(err)
                return
            }
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                Log.debug.out("Cannot get idToken")
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            self?.authWithFirebase(loginType: .google, credential: credential, completion: { result in
                switch result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    onFailed(error)
                }
            })
        }
    }
    
    func loginWithFacebook(vc: UIViewController, onSuccess: @escaping () -> Void, onFailed: @escaping (Error?) -> Void) {
        LoginManager().logIn(permissions: ["email","public_profile"], from: vc, handler: { [weak self] result, error in
            if let err = error {
                Log.debug.out((err as NSError).code)
                onFailed(err)
                return
            }
            guard let tokenString = AccessToken.current?.tokenString else {
                Log.debug.out("Cannot get token string current")
                return
            }
            if let fbLoginResult = result, fbLoginResult.isCancelled {
                Log.debug.out("The user canceled the sign-in flow.")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
            self?.authWithFirebase(loginType: .facebook, credential: credential, completion: { result in
                switch result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    onFailed(error)
                }
            })
        })
    }
    
    func signOut() -> Bool {
        if currentUser != nil {
            do {
                try Auth.auth().signOut()
                if let type = UserDefaults.standard.string(forKey: "loginType"),
                   let loginType = LoginService.LoginType(rawValue: type) {
                    switch loginType {
                    case .google:
                         GIDSignIn.sharedInstance.signOut()
                    case .facebook:
                        let fbLoginManager = LoginManager()
                        fbLoginManager.logOut()
                        let cookies = HTTPCookieStorage.shared
                        let facebookCookies = cookies.cookies(for: URL(string: "https://facebook.com/")!)
                        for cookie in facebookCookies! {
                            cookies.deleteCookie(cookie )
                        }
                    case .apple:
                        print("logout")
                    }
                }
                UserDefaults.standard.removeObject(forKey: "loginType")
                return true
            } catch  {
                Log.debug.out("Logout authentication for Firebase failed.")
                return false
            }
        }
        return false
    }
    
    func fetchFBLoggedInUserData(completion: @escaping (Result<[String:Any],Error>) -> ()) {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email,first_name,name,picture.type(normal)"])
        graphRequest.start(completion: { (connection, result, error) -> Void in
            if error != nil {
                completion(.failure(error!))
            } else if let dataResult = result as? [String:Any] {
                completion(.success(dataResult))
            }
        })
    }
    
    private func authWithFirebase(loginType: LoginType, credential: AuthCredential, completion: @escaping (Result<Bool,Error>) -> ()) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = self?.currentUser else {
                Log.debug.out("Cannot get current user from authentication for Firebase")
                return
            }
            let userProfile = UserProfile(
                userId: user.uid,
                name: user.displayName,
                email: user.email,
                phoneNumber: user.phoneNumber,
                imgAvatarUrl: user.photoURL?.absoluteString,
                isNewUser: true
            )
            FirebaseManager.shared.insertUser(user: userProfile, completion: { result in
                if result {
                    completion(.success(true))
                } else {
                    Log.debug.out("Cannot insert user profile into firebase data")
                }
            })
        }
    }
}
