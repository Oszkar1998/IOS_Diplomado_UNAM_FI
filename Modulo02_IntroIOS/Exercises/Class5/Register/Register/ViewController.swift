//
//  ViewController.swift
//  Register
//
//  Created by Oscar Cortes Calderon  on 25/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var contraseña: UITextField!
    @IBOutlet weak var buttonL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        contraseña.isSecureTextEntry = true
        buttonL.isEnabled = false
    }
    
    @IBAction func correoAction(_ sender: UITextField) {
        let textoCorreo = correo.text ?? ""
        let textoPassword = contraseña.text ?? ""
            
        // Se habilita solo si ambos campos tienen texto
        buttonL.isEnabled = !textoCorreo.isEmpty && !textoPassword.isEmpty
    }

    @IBAction func contraseñaAction(_ sender: UITextField) {
        let textoCorreo = correo.text ?? ""
        let textoPassword = contraseña.text ?? ""
            
        // Se habilita solo si ambos campos tienen texto
        buttonL.isEnabled = !textoCorreo.isEmpty && !textoPassword.isEmpty
    }
        
    @IBAction func buttonAction(_ sender: UIButton) {
        print("=== INICIO DE SESIÓN ===")
        print("Correo: \(correo.text ?? "")")
        print("Contraseña: \(contraseña.text ?? "")")
    }
}

