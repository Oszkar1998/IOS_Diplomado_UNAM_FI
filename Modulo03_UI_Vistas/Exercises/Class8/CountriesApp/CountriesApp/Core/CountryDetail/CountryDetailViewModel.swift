//
//  CountryDetailViewModel.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation
import UIKit

class CountryDetailViewModel {
    
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var countryName: String { country.nombre }
    var flagName: String { country.bandera }
    var capital: String { country.capital }
    var language: String { country.idioma }
    var currency: Currency { country.moneda }
    var currencyText: String { country.moneda.displayName }
    
    func getNumberOfStates() -> Int {
        country.estados.count
    }
    
    func getState(at indexPath: IndexPath) -> StateInfo {
        country.estados[indexPath.row]
    }
}
