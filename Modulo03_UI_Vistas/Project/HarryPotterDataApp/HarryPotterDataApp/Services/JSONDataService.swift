//
//  JSONDataService.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

class JSONDataService {
    static let shared = JSONDataService()
    private init() {}
    
    func loadCharacters() -> [Character] {
        guard let url = Bundle.main.url(forResource: "characters", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let characters = try? JSONDecoder().decode([Character].self, from: data) else {
            print("Error al cargar characters.json")
            return []
        }
        return characters
    }
    
    func loadMagicSections() -> [MagicSection] {
        guard let url = Bundle.main.url(forResource: "magic_archive", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(MagicArchiveResponse.self, from: data) else {
            print("Error al cargar magic_archive.json")
            return []
        }
        return response.sections
    }
}
