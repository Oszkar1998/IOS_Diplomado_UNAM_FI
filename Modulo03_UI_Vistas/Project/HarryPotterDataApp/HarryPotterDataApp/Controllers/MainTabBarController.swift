//
//  MainTabBarController.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {
        let expedientesVC = ExpedientesViewController()
        let expedientesNav = UINavigationController(rootViewController: expedientesVC)
        expedientesNav.tabBarItem = UITabBarItem(
            title: "Expedientes",
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill")
        )

        let archivoVC = ArchivoMagicoViewController()
        let archivoNav = UINavigationController(rootViewController: archivoVC)
        archivoNav.tabBarItem = UITabBarItem(
            title: "Archivo",
            image: UIImage(systemName: "sparkles"),
            selectedImage: UIImage(systemName: "sparkles")
        )

        let guardadosVC = GuardadosViewController()
        let guardadosNav = UINavigationController(rootViewController: guardadosVC)
        guardadosNav.tabBarItem = UITabBarItem(
            title: "Guardados",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )

        viewControllers = [expedientesNav, archivoNav, guardadosNav]
    }

    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "MinistrySurface") ?? .systemBackground

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor(named: "MinistryForest") ?? .systemGreen
    }
}
