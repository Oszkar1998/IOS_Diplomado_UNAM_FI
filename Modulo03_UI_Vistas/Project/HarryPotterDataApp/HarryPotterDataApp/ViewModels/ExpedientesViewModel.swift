//
//  ExpedientesViewModel.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

enum HouseFilter: String, CaseIterable {
    case todos = "Todos"
    case gryffindor = "Gryffindor"
    case slytherin = "Slytherin"
    case ravenclaw = "Ravenclaw"
    case hufflepuff = "Hufflepuff"
    case sinCasa = "Sin casa"
    
    func matches(character: Character) -> Bool {
        switch self {
        case .todos:
            return true
        case .gryffindor:
            return character.house?.lowercased() == "gryffindor"
        case .slytherin:
            return character.house?.lowercased() == "slytherin"
        case .ravenclaw:
            return character.house?.lowercased() == "ravenclaw"
        case .hufflepuff:
            return character.house?.lowercased() == "hufflepuff"
        case .sinCasa:
            return character.house == nil || character.house?.isEmpty == true
        }
    }
}

class ExpedientesViewModel {
    private let allCharacters: [Character]
    private(set) var filteredCharacters: [Character] = []
    
    var selectedHouse: HouseFilter = .todos {
        didSet { applyFilters() }
    }
    
    var searchText: String = "" {
        didSet { applyFilters() }
    }
    
    var onDataUpdated: (() -> Void)?
    
    init() {
        self.allCharacters = JSONDataService.shared.loadCharacters()
        self.filteredCharacters = allCharacters
    }
    
    func resetFilters() {
        selectedHouse = .todos
        searchText = ""
    }
    
    private func applyFilters() {
        let normalizedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines).normalizedForSearch()
        
        filteredCharacters = allCharacters.filter { character in
            let matchesHouse = selectedHouse.matches(character: character)
            
            if normalizedQuery.isEmpty {
                return matchesHouse
            }
            
            let nameMatch = character.name.normalizedForSearch().contains(normalizedQuery)
            let occupationMatch = character.occupation.normalizedForSearch().contains(normalizedQuery)
            return matchesHouse && (nameMatch || occupationMatch)
        }
        
        onDataUpdated?()
    }
}
