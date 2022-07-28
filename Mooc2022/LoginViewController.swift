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

        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: Any) {
        coordinator?.loginSuccess()
    }

}
