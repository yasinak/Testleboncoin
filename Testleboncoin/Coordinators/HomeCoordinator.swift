//
//  HomeCoordinator.swift
//  Testleboncoin
//
//  Created by Yasin Akinci on 29/04/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get }
    var navigationController: UINavigationController { get }
    
    func startCoordinator()
}

class HomeCoordinator {
    var childCoordinator: [Coordinator] = []
    var navigationController = UINavigationController()
    
    func startCoordinator() {
        let homeController = HomeViewController()
        navigationController.pushViewController(homeController, animated: false)
    }
}
