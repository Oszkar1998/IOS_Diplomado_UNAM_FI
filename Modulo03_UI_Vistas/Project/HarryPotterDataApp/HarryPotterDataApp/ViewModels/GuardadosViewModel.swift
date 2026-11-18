//
//  GuardadosViewModel.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

class GuardadosViewModel {
    private let allCharacters: [Character]
    private(set) var savedCharacters: [Character] = []
    
    var onDataUpdated: (() -> Void)?
    
    init() {
        self.allCharacters = JSONDataService.shared.loadCharacters()
        reloadFavorites()
    }
    
    func reloadFavorites() {
        let savedIDs = FavoritesService.shared.getSavedIDs()
        savedCharacters = savedIDs.compactMap { id in
            allCharacters.first { $0.id == id }
        }
        onDataUpdated?()
    }
    
    func removeFavorite(at index: Int) {
        guard index < savedCharacters.count else { return }
        let character = savedCharacters[index]
        FavoritesService.shared.removeFavorite(characterID: character.id)
    }
}
