//
//  InfoViewController.swift
//  CoffeApp
//
//  Created by Luis Fernando Gutierrez Orozpe on 03/10/26.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Info"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Esta es una aplicación para simular el sistema de gestion de ordenes de una cafetería. \n\n - La primera vista permite configurar el café para el cliente. \n\n - La segunda vista muestra el ticket de la orden generada. \n\n - La tercera vista muestra información de la aplicación."
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cerrar", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setHerarchy()
        setConstraints()
        setActions()
    }
    
    // Se encarga de establecer la jerarquía de los elementos en la vista
    private func setHerarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(dismissButton)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
            dismissButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            dismissButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            dismissButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24)
        ])
            
    }
    
    private func setActions() {
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    
    @objc private func dismissButtonPressed(_ sender: UIButton) {
        // Metodo que cierra una vista presentada de manera modal
        // ¿Cual vista?
        // La vista donde lo estas usando (ella misma)
        dismiss(animated: true)
    }
}
