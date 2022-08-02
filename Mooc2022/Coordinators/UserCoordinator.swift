//
//  UserCoordinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 02/08/2022.
//

import UIKit

class UserCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    weak var parrentCoordinator: MainCoodinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = AppDependencyProvider.userViewController
        controller.title = "User"
        controller.tabBarItem.image = UIImage.init(systemName: "person")
        controller.coordinator = parrentCoordinator
        navigationController.pushViewController(controller, animated: true)
    }
    
}
