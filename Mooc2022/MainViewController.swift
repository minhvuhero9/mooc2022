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
        let home = UINavigationController(rootViewController: AppDependencyProvider.homeViewController)
        home.title = "Home"
        home.tabBarItem.image = UIImage.init(systemName: "house")
        let list = UINavigationController(rootViewController: AppDependencyProvider.listViewController)
        list.title = "List"
        list.tabBarItem.image = UIImage.init(systemName: "music.note.list")
        self.tabBar.backgroundColor = .white
        self.viewControllers = [home, list]
    }
}
