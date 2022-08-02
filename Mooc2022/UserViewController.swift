//
//  UserViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 02/08/2022.
//

import UIKit

class UserViewController: UIViewController {

    weak var coordinator: MainCoodinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logOutAction(_ sender: Any) {
        coordinator?.logOut()
    }


}
