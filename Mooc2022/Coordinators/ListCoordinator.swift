//
//  ListCoordinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 02/08/2022.
//

import UIKit

class ListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = AppDependencyProvider.listViewController
        controller.title = "List"
        controller.tabBarItem.image = UIImage.init(systemName: "music.note.list")
        navigationController.pushViewController(controller, animated: true)
    }
}
