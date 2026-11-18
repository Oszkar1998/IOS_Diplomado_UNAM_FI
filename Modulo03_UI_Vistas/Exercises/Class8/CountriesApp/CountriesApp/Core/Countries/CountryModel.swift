//
//  CountryModel.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation

struct Country: Codable {
    let id: Int
    let nombre: String
    let bandera: String
    let capital: String
    let idioma: String
    let moneda: Currency
    let estados: [StateInfo]
}

struct Currency: Codable, Equatable {
    let codigo: String
    let nombre: String
    
    var displayName: String {
        "\(codigo) - \(nombre)"
    }
}

struct StateInfo: Codable {
    let nombre: String
    let lugares: [String]
}

typealias CurrencyRatesMap = [String: [String: Double]]
