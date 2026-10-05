//
//  ViewController.swift
//  RGBControlApp
//
//  Created by Oscar Cortes Calderon  on 02/10/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label1_1: UILabel!
    @IBOutlet weak var label1_2: UILabel!
    @IBOutlet weak var slider1: UISlider!
    
    @IBOutlet weak var label2_1: UILabel!
    @IBOutlet weak var label2_2: UILabel!
    @IBOutlet weak var slider2: UISlider!
    
    @IBOutlet weak var label3_1: UILabel!
    @IBOutlet weak var label3_2: UILabel!
    @IBOutlet weak var slider3: UISlider!
    
    @IBOutlet weak var buttonL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1. Configurar límites de los sliders (0 a 255)
        slider1.minimumValue = 0
        slider1.maximumValue = 255
        slider2.minimumValue = 0
        slider2.maximumValue = 255
        slider3.minimumValue = 0
        slider3.maximumValue = 255

        // 2. Establecer textos de las etiquetas de nombre
        label1_1.text = "Red Value"
        label2_1.text = "Green Value"
        label3_1.text = "Blue Value"

        // 3. Establecer valores iniciales
        slider1.value = 255
        slider2.value = 130
        slider3.value = 140

        label1_2.text = "255"
        label2_2.text = "130"
        label3_2.text = "140"

        buttonL.setTitle("Restablecer", for: .normal)

        // 4. Aplicar el color de fondo inicial
        let r = CGFloat(slider1.value) / 255.0
        let g = CGFloat(slider2.value) / 255.0
        let b = CGFloat(slider3.value) / 255.0
        view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    
    @IBAction func sliderUnoAction(_ sender: UISlider) {
        let val = Int(sender.value)
        label1_2.text = "\(val)"

        let r = CGFloat(sender.value) / 255.0
        let g = CGFloat(slider2.value) / 255.0
        let b = CGFloat(slider3.value) / 255.0
        view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    @IBAction func sliderDosAction(_ sender: UISlider) {
        let val = Int(sender.value)
        label2_2.text = "\(val)"

        let r = CGFloat(slider1.value) / 255.0
        let g = CGFloat(sender.value) / 255.0
        let b = CGFloat(slider3.value) / 255.0
        view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    @IBAction func sliderTresAction(_ sender: UISlider) {
        let val = Int(sender.value)
        label3_2.text = "\(val)"

        let r = CGFloat(slider1.value) / 255.0
        let g = CGFloat(slider2.value) / 255.0
        let b = CGFloat(sender.value) / 255.0
        view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

    
    @IBAction func buttonAction(_ sender: UIButton) {
        // Restablecer valores iniciales
        slider1.value = 255
        slider2.value = 130
        slider3.value = 140

        label1_2.text = "255"
        label2_2.text = "130"
        label3_2.text = "140"

        let r = CGFloat(255) / 255.0
        let g = CGFloat(130) / 255.0
        let b = CGFloat(140) / 255.0
        view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

