//
//  ViewController.swift
//  CoffeApp
//
//  Created by Luis Fernando Gutierrez Orozpe on 26/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var coffeTyeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sugarSlider: UISlider!
    @IBOutlet weak var sugarQuantity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.placeholder = "Ingresa el nombre del usuario"
        orderButton.setTitle("Ordenar", for: .normal)
        orderButton.isEnabled = false
        sugarQuantity.text = Int(round(sugarSlider.value)).description + " cucharada(s) de azúcar"
    }
    
    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        if sender.text == "" {
            orderButton.isEnabled = false
        } else {
            orderButton.isEnabled = true
        }
    }
    
    
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        print("Tu Orden es:")
        print("-------------------------")
        print(nameTextField.text ?? "")
        print(coffeTyeSegmentedControl.titleForSegment(at: coffeTyeSegmentedControl.selectedSegmentIndex)!)
        print("\(Int(sugarSlider.value)) cucharada(s) de azucar")
        print("-------------------------")
    }
    
    
    @IBAction func coffeTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Expresso")
        case 1:
            print("Latte")
        case 2:
            print("Capuccino")
        default:
            print("Unknown")
        }
    }
    
    
    @IBAction func sugarSilderChanged(_ sender: UISlider) {
        sugarQuantity.text = Int(round(sender.value)).description + " cucharada(s) de azúcar"
    }
}

