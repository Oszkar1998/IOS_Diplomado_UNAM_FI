//
//  OrderViewController.swift
//  CoffeAppXIBMain
//
//  Created by Luis Fernando Gutierrez Orozpe on 09/10/26.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func orderButtonPressed(_ sender: UIButton) {
        
        guard let ticketViewController = UIStoryboard(name: "TicketViewController", bundle: nil).instantiateViewController(identifier: "TicketViewController") as? TicketViewController else { return }
        
        navigationController?.pushViewController(ticketViewController, animated: true)
        
//        present(ticketViewController, animated: true)
    }
}
