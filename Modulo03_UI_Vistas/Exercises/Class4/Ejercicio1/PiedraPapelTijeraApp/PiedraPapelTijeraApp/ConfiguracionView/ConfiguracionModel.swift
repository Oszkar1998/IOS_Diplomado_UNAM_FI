//
//  ConfiguracionModel.swift
//  PiedraPapelTijeraApp
//
//  Created by Oscar Cortes Calderon  on 10/10/26.
//

import Foundation

enum GameMode {
    case rounds
    case points
}

struct GameConfiguration {
    let playerName: String
    let mode: GameMode
    
    // Rounds configuration
    let roundsNumber: Int
    
    // Points configuration
    let pointsToWinPerRound: Int
    let pointsToLosePerRound: Int
    let pointsNeededToWin: Int
}
