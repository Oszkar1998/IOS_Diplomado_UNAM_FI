//
//  FavoritesModel.swift
//  BobEsponjaApp
//
//  Created by Cristian Guillermo Romero Garcia on 24/10/26.
//

import Foundation
import UIKit

class FavoritesModel{
    
    var favoriteCharacters: [CharactersModel] = []
    
    init() {
        loadFavorite()
    }
    
    func loadFavorite(){
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKeys.favorite.rawValue) else {
            favoriteCharacters = []
            return
        }
        favoriteCharacters = (try? JSONDecoder().decode([CharactersModel].self, from: data)) ?? []
    }
    
    func getNumberOfRows() -> Int {
        favoriteCharacters.count
    }
    
    func getFavoriteCharacter(index: IndexPath) -> CharactersModel {
        favoriteCharacters[index.row]
    }
    
    func removeCharacters(at index: IndexPath) {
        var updateFavorites = favoriteCharacters
        updateFavorites.remove(at: index.row)
        guard let data = try? JSONEncoder().encode(updateFavorites) else { return }
        UserDefaults.standard.set(data, forKey: "favorite")
        favoriteCharacters.remove(at: index.row)
    }
}
