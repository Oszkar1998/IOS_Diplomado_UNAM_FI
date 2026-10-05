//
//  TicketViewController.swift
//  CoffeApp
//
//  Created by Luis Fernando Gutierrez Orozpe on 03/10/26.
//

import UIKit

class TicketViewController: UIViewController {
    
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var coffeTypeLabel: UILabel!
    @IBOutlet weak var sugarAmountLabel: UILabel!
    
    var clientName: String = ""
    var coffeType: String = ""
    var sugarAmount: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        clientNameLabel.text = clientName
        coffeTypeLabel.text = coffeType
        sugarAmountLabel.text = sugarAmount
    }
}
