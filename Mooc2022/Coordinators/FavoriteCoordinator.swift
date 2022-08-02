//
//  FavoriteCoordinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 02/08/2022.
//
import UIKit

class FavoriteCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    weak var parrentCoordinator: MainCoodinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = AppDependencyProvider.favoriteViewController
        controller.title = "Favorite"
        controller.tabBarItem.image = UIImage.init(systemName: "heart")
        navigationController.pushViewController(controller, animated: true)
    }
    
}
