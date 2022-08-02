//
//  MainCoordinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 26/07/2022.
//

import Foundation
import UIKit

class MainCoodinator: Coordinator {
    var childCoordinators = [Coordinator]()
 
    var navigationController: UINavigationController
    
    weak var parentCoordinator: LoginCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = AppDependencyProvider.mainTabbarController
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)

    }
    
    func logOut() {
        parentCoordinator?.logOut()
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
