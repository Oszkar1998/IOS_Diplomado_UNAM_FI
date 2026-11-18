//
//  CurrencyViewModel.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation

enum ConversionDirection {
    case leftToRight // ">" (De picker izquierdo a picker derecho)
    case rightToLeft // "<" (De picker derecho a picker izquierdo)
    
    var symbolSystemName: String {
        switch self {
        case .leftToRight:
            return "chevron.right.circle.fill"
        case .rightToLeft:
            return "chevron.left.circle.fill"
        }
    }
    
    var descriptionText: String {
        switch self {
        case .leftToRight:
            return "Convirtiendo de izquierda a derecha (>)"
        case .rightToLeft:
            return "Convirtiendo de derecha a izquierda (<)"
        }
    }
}

class CurrencyViewModel {
    
    private let dataManager: DataManager
    private var ratesMap: CurrencyRatesMap = [:]
    
    private(set) var currencies: [Currency] = []
    private(set) var leftSelectedIndex: Int = 0
    private(set) var rightSelectedIndex: Int = 1
    private(set) var direction: ConversionDirection = .leftToRight
    
    init(currencies: [Currency], dataManager: DataManager = DataManager()) {
        self.currencies = currencies
        self.dataManager = dataManager
        if currencies.count <= 1 {
            self.rightSelectedIndex = 0
        }
        loadRates()
    }
    
    private func loadRates() {
        do {
            ratesMap = try dataManager.loadCurrencyRates()
        } catch {
            print("Error cargando tasas de cambio: \(error.localizedDescription)")
        }
    }
    
    func getNumberOfCurrencies() -> Int {
        currencies.count
    }
    
    func getCurrencyTitle(at row: Int) -> String {
        currencies[row].displayName
    }
    
    func updateLeftSelection(row: Int) {
        leftSelectedIndex = row
        direction = .leftToRight
    }
    
    func updateRightSelection(row: Int) {
        rightSelectedIndex = row
        direction = .rightToLeft
    }
    
    func toggleDirection() {
        direction = (direction == .leftToRight) ? .rightToLeft : .leftToRight
    }
    
    func selectSourceCurrency(_ currency: Currency) -> Int? {
        guard let index = currencies.firstIndex(of: currency) else { return nil }
        leftSelectedIndex = index
        direction = .leftToRight
        return index
    }
    
    func convert(amountText: String?) -> Result<String, ConversionError> {
        guard let rawText = amountText?.trimmingCharacters(in: .whitespacesAndNewlines),
              !rawText.isEmpty else {
            return .failure(.emptyInput)
        }
        
        // Bloqueo explícito contra signo negativo
        if rawText.contains("-") {
            return .failure(.negativeNotAllowed)
        }
        
        // Permite coma o punto decimal
        let normalized = rawText.replacingOccurrences(of: ",", with: ".")
        guard let amount = Double(normalized) else {
            return .failure(.invalidNumber)
        }
        
        guard amount >= 0 else {
            return .failure(.negativeNotAllowed)
        }
        
        guard !currencies.isEmpty else {
            return .failure(.missingRates)
        }
        
        let sourceCurrency: Currency
        let targetCurrency: Currency
        
        switch direction {
        case .leftToRight:
            sourceCurrency = currencies[leftSelectedIndex]
            targetCurrency = currencies[rightSelectedIndex]
        case .rightToLeft:
            sourceCurrency = currencies[rightSelectedIndex]
            targetCurrency = currencies[leftSelectedIndex]
        }
        
        guard let rate = ratesMap[sourceCurrency.codigo]?[targetCurrency.codigo] else {
            return .failure(.missingRates)
        }
        
        // Garantiza que el resultado nunca sea negativo
        let convertedValue = abs(amount * rate)
        let formattedSource = String(format: "%.2f", abs(amount))
        let formattedResult = String(format: "%.2f", convertedValue)
        
        return .success("\(formattedSource) \(sourceCurrency.codigo) = \(formattedResult) \(targetCurrency.codigo)")
    }
}

enum ConversionError: LocalizedError {
    case emptyInput
    case negativeNotAllowed
    case invalidNumber
    case missingRates
    
    var errorDescription: String? {
        switch self {
        case .emptyInput:
            return "Ingresa una cantidad numérica."
        case .negativeNotAllowed:
            return "No se permiten números negativos."
        case .invalidNumber:
            return "Ingresa un número válido."
        case .missingRates:
            return "No se encontró la tasa de conversión."
        }
    }
}
