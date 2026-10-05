//
//  ViewController.swift
//  DayWallpapersApp
//
//  Created by Oscar Cortes Calderon  on 02/10/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageL: UIImageView!
    @IBOutlet weak var segmentL: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Carga inicial: Segmento 0 (Mañana)
        segmentL.selectedSegmentIndex = 0
        imageL.image = UIImage(named: "Tomorrow")
    }

    @IBAction func segmentL(_ sender: UISegmentedControl) {
        // Evaluamos el índice seleccionado en el Segmented Control
        switch sender.selectedSegmentIndex {
            case 0:
                // Mañana
                imageL.image = UIImage(named: "Tomorrow")
            case 1:
                // Tarde
                imageL.image = UIImage(named: "Late")
            case 2:
                // Noche
                imageL.image = UIImage(named: "Evening")
            default:
                break
        }
    }
    
}

