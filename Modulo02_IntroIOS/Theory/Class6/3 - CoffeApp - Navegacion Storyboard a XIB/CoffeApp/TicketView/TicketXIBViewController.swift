//
//  TicketXIBViewController.swift
//  CoffeApp
//
//  Created by Luis Fernando Gutierrez Orozpe on 03/10/26.
//

import UIKit

class TicketXIBViewController: UIViewController {

    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var coffeTypeLabel: UILabel!
    @IBOutlet weak var sugarAmountLabel: UILabel!
    
    var clientName: String = ""
    var coffeType: String = ""
    var sugarAmount: String = ""
    var orderHistory: [OrderInfo] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        clientNameLabel.text = clientName
        coffeTypeLabel.text = coffeType
        sugarAmountLabel.text = sugarAmount
        setupOrderAlert()
    }
    
    private func setupOrderAlert() {
        if orderHistory.count == 2 {
            let alert = UIAlertController(title: "Hey calamardo", message: "El negocio va prosperando", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Gracias calamardo", style: .default))
            alert.addAction(UIAlertAction(title: "De nada", style: .default))
            present(alert, animated: true)
        }
    }
}
