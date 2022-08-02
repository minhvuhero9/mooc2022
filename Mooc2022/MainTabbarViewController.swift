//
//  MainViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 11/07/2022.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    weak var coordinator: MainCoodinator?
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    let listCoordinator = ListCoordinator(navigationController: UINavigationController())
    let userCoordinator = UserCoordinator(navigationController: UINavigationController())
    let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userCoordinator.parrentCoordinator = coordinator
        homeCoordinator.start()
        listCoordinator.start()
        favoriteCoordinator.start()
        userCoordinator.start()
        
        self.viewControllers = [homeCoordinator.navigationController, listCoordinator.navigationController,
            favoriteCoordinator.navigationController,
            userCoordinator.navigationController]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinish()
    }

}
