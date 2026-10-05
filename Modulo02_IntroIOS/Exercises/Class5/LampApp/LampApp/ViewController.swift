//
//  ViewController.swift
//  LampApp
//
//  Created by Oscar Cortes Calderon  on 02/10/26.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tittleL: UILabel!
    @IBOutlet weak var imageL: UIImageView!
    @IBOutlet weak var buttonL: UIButton!
    
    // Empieza con la lámpara encendida
    private var ondOff: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración visual inicial (Estado: ENCENDIDA)
        tittleL.font = UIFont.boldSystemFont(ofSize: 22)
        tittleL.textAlignment = .center
        tittleL.text = "Me gusta la luz"
        tittleL.textColor = .black
        
        imageL.image = UIImage(named: "Sun")
        
        buttonL.setTitle("Turn Off", for: .normal)
        buttonL.setTitleColor(.white, for: .normal)
        buttonL.backgroundColor = .systemBlue
        
        view.backgroundColor = .white
    }
    
    
    @IBAction func buttonA(_ sender: UIButton) {
        // Alternamos el estado
        ondOff.toggle()
        
        if ondOff {
            // ESTADO: ENCENDIDA
            tittleL.text = "Me gusta la luz"
            tittleL.textColor = .black
            
            imageL.image = UIImage(named: "Sun")
            
            buttonL.setTitle("Turn Off", for: .normal)
            buttonL.setTitleColor(.white, for: .normal)
            buttonL.backgroundColor = .systemBlue
            
            view.backgroundColor = .white
        } else {
            // ESTADO: APAGADA
            tittleL.text = "Prefiero la obscuridad"
            tittleL.textColor = .white
            
            imageL.image = UIImage(named: "Moon")
            
            buttonL.setTitle("Turn On", for: .normal)
            buttonL.setTitleColor(.black, for: .normal)
            buttonL.backgroundColor = .systemYellow
            
            view.backgroundColor = .black
        }
    }
}

    
