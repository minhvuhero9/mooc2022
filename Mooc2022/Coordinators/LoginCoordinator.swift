//
//  LoginCoordinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 25/07/2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: true)
        let controller = AppDependencyProvider.loginViewController
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func loginSuccess() {
        let child = MainCoodinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func logOut() {
        LoginService.shared.signOut()
        navigationController.popViewController(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
