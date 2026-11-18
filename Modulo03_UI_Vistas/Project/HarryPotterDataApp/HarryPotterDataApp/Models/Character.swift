//
//  Character.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

struct Character: Codable, Equatable {
    let id: String
    let name: String
    let imageName: String
    let house: String?
    let occupation: String
    let affiliation: String
    let status: String
    let description: String
    let reward: Int?
    
    var houseDisplayName: String {
        guard let house = house else { return "Sin casa" }
        switch house.lowercased() {
        case "gryffindor": return "Gryffindor"
        case "slytherin": return "Slytherin"
        case "ravenclaw": return "Ravenclaw"
        case "hufflepuff": return "Hufflepuff"
        default: return "Sin casa"
        }
    }
    
    var statusDisplayName: String {
        switch status.lowercased() {
        case "activo": return "Activo"
        case "en_observacion": return "En observación"
        case "reservado": return "Reservado"
        case "buscado": return "Buscado"
        case "archivado": return "Archivado"
        case "protegido": return "Protegido"
        default: return status.capitalized
        }
    }
}
