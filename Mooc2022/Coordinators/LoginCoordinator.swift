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
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func loginSuccess() {
        let coordinator = MainCoodinator(navigationController: navigationController)
        coordinator.start()
    }

}
