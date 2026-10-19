
//
//  GameViewController.swift
//  PiedraPapelTijeraApp
//
//  Created by Oscar Cortes Calderon on 10/10/26.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cpuChoiceImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var userChoiceImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Selection Buttons
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    // Action Buttons
    @IBOutlet weak var nextTurnButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!

    var gameConfiguration: GameConfiguration?
    
    private var currentRound: Int = 1
    private var currentPoints: Int = 0
    private var gameHistory: [String] = []
    
    enum Option: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    private func setupGame() {
        guard let config = gameConfiguration else { return }
        
        let name = config.playerName.trimmingCharacters(in: .whitespaces).isEmpty ? "Jugador" : config.playerName
        playerNameLabel?.text = "Jugador: \(name)"
        
        title = config.mode == .rounds ? "Juego por Rondas" : "Juego por Puntos"
        
        updateScoreLabel()
        resetTurnUI()
    }
    
    private func updateScoreLabel() {
        guard let config = gameConfiguration else { return }
        
        if config.mode == .rounds {
            scoreLabel?.text = "Ronda: \(currentRound) de \(config.roundsNumber)"
        } else {
            scoreLabel?.text = "Puntos: \(currentPoints) / \(config.pointsNeededToWin)"
        }
    }
    
    @IBAction func optionSelected(_ sender: UIButton) {
        guard let config = gameConfiguration else { return }
        
        var userOption: Option = .rock
        if sender == paperButton { userOption = .paper }
        else if sender == scissorsButton { userOption = .scissors }
        
        guard let cpuOption = Option.allCases.randomElement() else { return }
        
        userChoiceImageView?.image = UIImage(named: userOption.rawValue)
        cpuChoiceImageView?.image = UIImage(named: cpuOption.rawValue)
        
        setSelectionButtons(enabled: false)
        nextTurnButton?.isHidden = false
        
        evaluateTurn(user: userOption, cpu: cpuOption, config: config)
    }
    
    private func evaluateTurn(user: Option, cpu: Option, config: GameConfiguration) {
        if user == cpu {
            view.backgroundColor = .systemGroupedBackground
            resultLabel?.text = "¡Empate! 🤝"
            resultLabel?.textColor = .label
            gameHistory.append("Ronda \(currentRound): Empate")
        } else if (user == .rock && cpu == .scissors) ||
                  (user == .paper && cpu == .rock) ||
                  (user == .scissors && cpu == .paper) {
            view.backgroundColor = .systemGreen
            resultLabel?.text = "¡Ganaste esta ronda! 🎉"
            resultLabel?.textColor = .white
            if config.mode == .points {
                currentPoints += config.pointsToWinPerRound
            }
            gameHistory.append("Ronda \(currentRound): Ganaste")
        } else {
            view.backgroundColor = .systemRed
            resultLabel?.text = "¡Perdiste esta ronda! 💥"
            resultLabel?.textColor = .white
            if config.mode == .points {
                currentPoints -= config.pointsToLosePerRound
            }
            gameHistory.append("Ronda \(currentRound): Perdiste")
        }
        
        updateScoreLabel()
        checkGameCompletion(config: config)
    }
    
    private func checkGameCompletion(config: GameConfiguration) {
        var isCompleted = false
        
        if config.mode == .rounds && currentRound >= config.roundsNumber {
            isCompleted = true
        } else if config.mode == .points && currentPoints >= config.pointsNeededToWin {
            isCompleted = true
        }
        
        if isCompleted {
            showGameFinishedAlert()
        }
    }

    
    @IBAction func nextTurnButtonPressed(_ sender: UIButton) {
        currentRound += 1
        updateScoreLabel()
        resetTurnUI()
    }
    
    @IBAction func resetGameButtonPressed(_ sender: UIButton) {
        currentRound = 1
        currentPoints = 0
        gameHistory.removeAll()
        updateScoreLabel()
        resetTurnUI()
    }
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        let historyVC = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        historyVC.historyList = gameHistory
        navigationController?.pushViewController(historyVC, animated: true)
    }

    private func resetTurnUI() {
        view.backgroundColor = .systemBackground
        resultLabel?.text = "Elige tu jugada"
        resultLabel?.textColor = .secondaryLabel
        userChoiceImageView?.image = nil
        cpuChoiceImageView?.image = nil
        setSelectionButtons(enabled: true)
        nextTurnButton?.isHidden = true
    }
    
    private func setSelectionButtons(enabled: Bool) {
        rockButton?.isEnabled = enabled
        paperButton?.isEnabled = enabled
        scissorsButton?.isEnabled = enabled
    }
    
    private func showGameFinishedAlert() {
        guard let config = gameConfiguration else { return }
        
        let totalWins = gameHistory.filter { $0.contains("Ganaste") }.count
        let totalLosses = gameHistory.filter { $0.contains("Perdiste") }.count
        
        let alertTitle: String
        let alertMessage: String
        
        if config.mode == .rounds {
            if totalWins > totalLosses {
                alertTitle = "¡Felicidades, Ganaste el Juego! 🎉"
                alertMessage = "Ganaste \(totalWins) de \(config.roundsNumber) rondas."
            } else if totalLosses > totalWins {
                alertTitle = "¡Juego Terminado! 💥"
                alertMessage = "Perdiste el juego. Ganaste \(totalWins) ronda(s) y perdiste \(totalLosses)."
            } else {
                alertTitle = "¡Empate Final! 🤝"
                alertMessage = "El juego terminó en empate."
            }
        } else {
            if currentPoints >= config.pointsNeededToWin {
                alertTitle = "¡Felicidades, Ganaste el Juego! 🎉"
                alertMessage = "Alcanzaste la meta de \(config.pointsNeededToWin) puntos."
            } else {
                alertTitle = "¡Juego Terminado! 💥"
                alertMessage = "No lograste alcanzar la puntuación requerida."
            }
        }
        
        let alert = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Reiniciar Juego", style: .default) { _ in
            self.resetGameButtonPressed(UIButton())
        })
        
        alert.addAction(UIAlertAction(title: "Configuración", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
}
