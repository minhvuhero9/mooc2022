//
//  HomeCoodinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 02/08/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = AppDependencyProvider.homeViewController
        controller.title = "Home"
        controller.tabBarItem.image = UIImage.init(systemName: "house")
        navigationController.pushViewController(controller, animated: true)
    }
    
}
