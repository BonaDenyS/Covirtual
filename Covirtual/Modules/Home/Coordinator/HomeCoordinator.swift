//
//  HomeCoordinator.swift
//  Covirtual
//
//  Created by Bona Deny S on 09/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class HomeCoordinator {
    let navigationController: UINavigationController
    var childCoordinator: CoordinatorProtocol? = nil
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol
extension HomeCoordinator: CoordinatorProtocol {
    func start() {
        let homeView = HomeView.create()
        var viewModel = HomeViewModel()
        viewModel.coordinatorDelegate = self
        homeView.viewModel = viewModel
//        navigationController.tabBarItem.image = UIImage(named: "home")?.resized(toWidth: 30.0)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 3.0, right: 2.0)
        navigationController.pushViewController(homeView, animated: false)
    }
}

// MARK: - CevirmeCoordinatorViewModelDelegate
extension HomeCoordinator: HomeCoordinatorViewModelDelegate {
    
}
