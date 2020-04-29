//
//  AppCoordinator.swift
//  Covirtual
//
//  Created by Bona Deny S on 09/04/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    let window: UIWindow
    
    // We have to store the references to the coordinators to prevent them from beeing deinitialized
    var coordinators: [CoordinatorProtocol] = []
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - CoordinatorProtocol
extension AppCoordinator {
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = []
        
        let homeTab = createNavigationController(withTitle: "Home")
//        let greenTab = createNavigationController(withTitle: "FACevirmek")
//        let fiilTab = createNavigationController(withTitle: "Fiil")
//        let cevirmeTab = createNavigationController(withTitle: "Çevirme")
        
//        let dersTab = createNavigationController(withTitle: "Ders")
//        let ipuclariTab = createNavigationController(withTitle: "İpuçlari")
//        let sohbetTab = createNavigationController(withTitle: "Sohbet")

        let homeCoordinator = HomeCoordinator(navigationController: homeTab)
        coordinators.append(homeCoordinator)
        homeCoordinator.start()
//
//        let cevirmeCoordinator = CevirmeCoordinator(navigationController: cevirmeTab)
//        coordinators.append(cevirmeCoordinator)
//        cevirmeCoordinator.start()
        
//        let dersCoordinator = CevirmeCoordinator(navigationController: dersTab)
//        coordinators.append(dersCoordinator)
//        dersCoordinator.start()
        
//        let ipuclariCoordinator = CevirmeCoordinator(navigationController: ipuclariTab)
//        coordinators.append(ipuclariCoordinator)
//        ipuclariCoordinator.start()
        
//        let sohbetCoordinator = CevirmeCoordinator(navigationController: sohbetTab)
//        coordinators.append(sohbetCoordinator)
//        sohbetCoordinator.start()
        
        
//        let greenCoordinator = GreenCoordinator(navigationController: greenTab)
//        coordinators.append(greenCoordinator)
//        greenCoordinator.start()
        
        let rootViewControllers = [homeTab]
        tabBarController.setViewControllers(rootViewControllers, animated: false)
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9943922162, green: 0.7572752833, blue: 0.03132825717, alpha: 1)
        
        window.rootViewController = tabBarController
    }
}

// MARK: - Creating tabs
extension AppCoordinator {
    func createNavigationController(withTitle title: String) -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        
        navController.tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        return navController
    }
}
