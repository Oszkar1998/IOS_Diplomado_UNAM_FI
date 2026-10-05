//
//  ViewController.swift
//  CoffeApp
//
//  Created by Luis Fernando Gutierrez Orozpe on 26/09/26.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var coffeTyeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sugarSlider: UISlider!
    @IBOutlet weak var sugarQuantity: UILabel!
    @IBOutlet weak var milkSwitch: UISwitch!
    @IBOutlet weak var milkSlider: UISlider!
    @IBOutlet weak var milkLabel: UILabel!
    
    
    private var orderHistory: [OrderInfo] = []
    
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
        // MARK: - Preparar la navegación a un XIB
        let name = nameTextField.text ?? ""
        let coffe = coffeTyeSegmentedControl.titleForSegment(at: coffeTyeSegmentedControl.selectedSegmentIndex) ?? ""
        let sugar = "\(Int(sugarSlider.value)) cucharadas de azucar"
        
        orderHistory.append(OrderInfo(clientName: name,
                                      coffeType: coffe,
                                      sugarAmount: sugar))
        
        let ticketViewXIB = TicketXIBViewController(nibName: "TicketXIBViewController", bundle: nil)
        ticketViewXIB.clientName = name
        ticketViewXIB.coffeType = coffe
        ticketViewXIB.sugarAmount = sugar
        ticketViewXIB.orderHistory = orderHistory
        
        // Metodo para navegar con stack de navegación
        self.navigationController?.pushViewController(ticketViewXIB, animated: true)
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
    
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        let infoView = InfoViewController()
        // Metodo para navegar como modal
        present(infoView, animated: true)
    }
    
    @IBAction func milkSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            milkSlider.isHidden = false
            milkLabel.isHidden = false
        } else {
            milkSlider.isHidden = true
            milkLabel.isHidden = true
        }
    }
}

