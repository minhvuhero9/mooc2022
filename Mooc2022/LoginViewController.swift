//
//  LoginViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    weak var coordinator: LoginCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        checkAccountLoggedIn()
    }
    
    @IBAction func pressedLoginWithFacebook(_ sender: Any) {
        loginWithFacebookAction()
    }
    
    @IBAction func pressedLoginWithGoogle(_ sender: Any) {
        loginWithGoogleAction()
    }
    
    func goToHomeController() {
        let main = MainViewController()
        navigationController?.pushViewController(main, animated: false)
    }
    
    func checkAccountLoggedIn() {
        let currentUser = LoginService.shared.currentUser
        Log.debug.out("Provider uid current: \(currentUser?.uid ?? "")")
        if currentUser != nil {
            goToHomeController()
        }
    }
    // MARK: Google login method
    func loginWithGoogleAction() {
        LoginService.shared.loginWithGoogle(
            vc: self,
            onSuccess: { [weak self] in
                UserDefaults.standard.set(LoginService.LoginType.google.rawValue, forKey: "loginType")
                self?.goToHomeController()
            },
            onFailed: { [weak self] error in
                self?.showMessagePrompt(error?.localizedDescription ?? "Unknown")
            }
        )
    }
    
    // MARK: Facebook login method
    func loginWithFacebookAction() {
        LoginService.shared.loginWithFacebook(
            vc: self,
            onSuccess: { [weak self] in
                UserDefaults.standard.set(LoginService.LoginType.facebook.rawValue, forKey: "loginType")
                self?.goToHomeController()
            },
            onFailed: { [weak self] error in
                self?.showMessagePrompt(error?.localizedDescription ?? "Unknown")
            }
        )
    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
