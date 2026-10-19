//
//  ConfiguracionViewController.swift
//  PiedraPapelTijeraApp
//
//  Created by Oscar Cortes Calderon  on 10/10/26.
//

import UIKit

class ConfiguracionViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var roundsContainerStack: UIStackView!
    @IBOutlet weak var roundsValueLabel: UILabel!
    @IBOutlet weak var roundsSlider: UISlider!
    
    @IBOutlet weak var pointsContainerStack: UIStackView!
    @IBOutlet weak var pointsToWinTextField: UITextField!
    @IBOutlet weak var pointsToLoseTextField: UITextField!
    @IBOutlet weak var pointsNeededToWinTextField: UITextField!
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        continueButton.isEnabled = false // Disabled by default
        
        // Initial state: Show rounds, hide points
        roundsContainerStack.isHidden = false
        pointsContainerStack.isHidden = true
        
        // Slider range configuration (1 to 5 rounds)
        roundsSlider.minimumValue = 1
        roundsSlider.maximumValue = 5
        roundsSlider.value = 1
        roundsValueLabel.text = "1"
        
        nameTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        pointsToWinTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        pointsToLoseTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        pointsNeededToWinTextField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    }

    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        let isRoundsMode = sender.selectedSegmentIndex == 0
        
        roundsContainerStack.isHidden = !isRoundsMode
        puntosContainerStackOpcional(isRoundsMode: isRoundsMode)
        
        validateFields()
    }
    
    private func puntosContainerStackOpcional(isRoundsMode: Bool) {
        pointsContainerStack.isHidden = isRoundsMode
    }
    
    @IBAction func roundsSliderChanged(_ sender: UISlider) {
        let integerValue = Int(round(sender.value))
        sender.value = Float(integerValue)
        roundsValueLabel.text = "\(integerValue)"
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        let selectedMode: GameMode = modeSegmentedControl.selectedSegmentIndex == 0 ? .rounds : .points
        
        let config = GameConfiguration(
            playerName: nameTextField.text ?? "",
            mode: selectedMode,
            roundsNumber: Int(roundsSlider.value),
            pointsToWinPerRound: Int(pointsToWinTextField.text ?? "") ?? 0,
            pointsToLosePerRound: Int(pointsToLoseTextField.text ?? "") ?? 0,
            pointsNeededToWin: Int(pointsNeededToWinTextField.text ?? "") ?? 0
        )
        
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        if let gameVC = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            gameVC.gameConfiguration = config
            navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    

    @objc private func validateFields() {
        guard let name = nameTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            continueButton.isEnabled = false
            return
        }
        
        if modeSegmentedControl.selectedSegmentIndex == 0 {
            
            continueButton.isEnabled = true
        } else {
            
            let hasPointsToWin = !(pointsToWinTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
            let hasPointsToLose = !(pointsToLoseTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
            let hasPointsNeededToWin = !(pointsNeededToWinTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
            
            continueButton.isEnabled = hasPointsToWin && hasPointsToLose && hasPointsNeededToWin
        }
    }
    
}
