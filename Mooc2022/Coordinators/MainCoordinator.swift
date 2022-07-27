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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
}
