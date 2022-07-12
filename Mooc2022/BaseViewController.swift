//
//  BaseViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 11/07/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController \(type(of: self))")
        print("ViewController.Xib \(self.nibName ?? "dont know")")
        self.navigationController?.navigationBar.backgroundColor = .white
    }

}
