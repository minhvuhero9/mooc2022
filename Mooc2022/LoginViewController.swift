//
//  LoginViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: Any) {
        let main = MainViewController()
        navigationController?.pushViewController(main, animated: false)
    }

}
