//
//  CountriesViewModel.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation
import UIKit

class CountriesViewModel {
    
    private let dataManager: DataManager
    private(set) var countries: [Country] = []
    
    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
        loadCountries()
    }
    
    private func loadCountries() {
        do {
            countries = try dataManager.loadCountries()
        } catch {
            print("Error cargando países: \(error.localizedDescription)")
        }
    }
    
    func getNumberOfCountries() -> Int {
        countries.count
    }
    
    func getCountry(at indexPath: IndexPath) -> Country {
        countries[indexPath.item]
    }
    
    // Extrae las monedas únicas de los países cargados para alimentar el Tab de Currency
    func getAvailableCurrencies() -> [Currency] {
        var uniqueCurrencies: [Currency] = []
        for country in countries {
            if !uniqueCurrencies.contains(country.moneda) {
                uniqueCurrencies.append(country.moneda)
            }
        }
        return uniqueCurrencies
    }
}
