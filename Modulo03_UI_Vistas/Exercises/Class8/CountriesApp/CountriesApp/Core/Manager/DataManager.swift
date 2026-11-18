//
//  DataManager.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation

enum LocalJSONError: LocalizedError {
    case fileNotFound(String)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):
            return "No se encontró el archivo: \(name)"
        }
    }
}

class DataManager {
    
    func loadCountries() throws -> [Country] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            throw LocalJSONError.fileNotFound("countries.json")
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Country].self, from: data)
    }
    
    func loadCurrencyRates() throws -> CurrencyRatesMap {
        guard let url = Bundle.main.url(forResource: "currency_conversion", withExtension: "json") else {
            throw LocalJSONError.fileNotFound("currency_conversion.json")
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(CurrencyRatesMap.self, from: data)
    }
}
