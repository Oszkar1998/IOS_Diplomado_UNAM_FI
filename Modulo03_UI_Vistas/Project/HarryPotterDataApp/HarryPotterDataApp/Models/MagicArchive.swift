//
//  MagicArchive.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

struct MagicArchiveResponse: Codable {
    let sections: [MagicSection]
}

struct MagicSection: Codable {
    let id: String
    let title: String
    let items: [MagicItem]
}

struct MagicFact: Codable {
    let label: String
    let value: String
}

struct MagicItem: Codable {
    let id: String
    let name: String
    let imageName: String
    let description: String
    let detailLabel: String
    let detailValue: String
    let category: String
    let subtype: String
    let usage: String
    let difficulty: String?
    let dangerLevel: String
    let isRestricted: Bool
    let isUnforgivable: Bool
    let isHorcrux: Bool
    let incantation: String?
    let tags: [String]
    let facts: [MagicFact]
    let precautions: String
    
    var categoryDisplayName: String {
        switch category.lowercased() {
        case "spells": return "Hechizos"
        case "potions": return "Pociones"
        case "objects": return "Objetos misteriosos"
        default: return category.capitalized
        }
    }
    
    var difficultyDisplayName: String? {
        guard let difficulty = difficulty else { return nil }
        switch difficulty.lowercased() {
        case "basica": return "Básica"
        case "intermedia": return "Intermedia"
        case "avanzada": return "Avanzada"
        default: return difficulty.capitalized
        }
    }
    
    var dangerDisplayName: String {
        switch dangerLevel.lowercased() {
        case "bajo": return "Bajo"
        case "medio": return "Medio"
        case "alto": return "Alto"
        case "critico": return "Crítico"
        default: return dangerLevel.capitalized
        }
    }
}
