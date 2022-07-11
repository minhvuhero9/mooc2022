//
//  MainViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 11/07/2022.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        homeViewController.tabBarItem.image = UIImage.init(systemName: "house")
        let listViewController = ListViewController()
        listViewController.title = "List"
        listViewController.tabBarItem.image = UIImage.init(systemName: "music.note.list")
        self.tabBar.backgroundColor = .white
        self.viewControllers = [homeViewController, listViewController]
    }
}
