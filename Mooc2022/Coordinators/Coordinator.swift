//
//  Coordinator.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 25/07/2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
