//
//  FavoritesService.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

extension Notification.Name {
    static let favoritesDidChange = Notification.Name("favoritesDidChange")
}

class FavoritesService {
    static let shared = FavoritesService()
    private let defaultsKey = "saved_character_ids"
    
    private init() {}
    
    func getSavedIDs() -> [String] {
        return UserDefaults.standard.stringArray(forKey: defaultsKey) ?? []
    }
    
    func isFavorite(characterID: String) -> Bool {
        return getSavedIDs().contains(characterID)
    }
    
    func addFavorite(characterID: String) {
        var current = getSavedIDs()
        guard !current.contains(characterID) else { return } // Evita duplicados
        current.append(characterID)
        UserDefaults.standard.set(current, forKey: defaultsKey)
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
    
    func removeFavorite(characterID: String) {
        var current = getSavedIDs()
        current.removeAll { $0 == characterID }
        UserDefaults.standard.set(current, forKey: defaultsKey)
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
    
    func toggleFavorite(characterID: String) {
        if isFavorite(characterID: characterID) {
            removeFavorite(characterID: characterID)
        } else {
            addFavorite(characterID: characterID)
        }
    }
}
