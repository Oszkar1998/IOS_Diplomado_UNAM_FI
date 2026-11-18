//
//  MainTabBarController.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    private let countriesViewModel = CountriesViewModel()
    private var currencyViewController: CurrencyViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        // Tab 1: Countries
        let countriesVC = CountriesViewController(viewModel: countriesViewModel)
        countriesVC.delegate = self
        let countriesNav = UINavigationController(rootViewController: countriesVC)
        countriesNav.tabBarItem = UITabBarItem(
            title: "Countries",
            image: UIImage(systemName: "globe.americas"),
            selectedImage: UIImage(systemName: "globe.americas.fill")
        )
        
        // Tab 2: Currency
        let availableCurrencies = countriesViewModel.getAvailableCurrencies()
        let currencyVM = CurrencyViewModel(currencies: availableCurrencies)
        let currencyVC = CurrencyViewController(viewModel: currencyVM)
        self.currencyViewController = currencyVC
        
        let currencyNav = UINavigationController(rootViewController: currencyVC)
        currencyNav.tabBarItem = UITabBarItem(
            title: "Currency",
            image: UIImage(systemName: "dollarsign.circle"),
            selectedImage: UIImage(systemName: "dollarsign.circle.fill")
        )
        
        viewControllers = [countriesNav, currencyNav]
        selectedIndex = 0
    }
}

extension MainTabBarController: CountriesViewControllerDelegate {
    func didRequestCurrencyConversion(with currency: Currency) {
        selectedIndex = 1
        currencyViewController?.setPreselectedCurrency(currency)
    }
}
