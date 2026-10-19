//
//  InfoViewController.swift
//  PiedraPapelTijeraApp
//
//  Created by Oscar Cortes Calderon  on 10/10/26.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reglas del Juego"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        ¡Bienvenido a Piedra, Papel o Tijeras!
        
        Reglas Básicas:
        • Piedra vence a Tijera.
        • Tijera vence a Papel.
        • Papel vence a Piedra.
        
        Modos de Juego:
        
        1. Por Rondas:
        Compite durante el número seleccionado de rondas (1 a 5). El jugador que gane la última ronda o tenga más victorias completará la partida.
        
        2. Por Puntos:
        Acumula puntos ganando rondas. Sumas puntos al ganar y restas puntos al perder. ¡El primero en alcanzar el puntaje objetivo gana!
        """
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entendido", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setHierarchy()
        setConstraints()
        setActions()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
    }

    private func setHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(dismissButton)
    }

    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            // Title Constraints
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),

            // Description Constraints
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),

            // Dismiss Button Constraints
            dismissButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            dismissButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            dismissButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setActions() {
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }

    @objc private func dismissButtonPressed() {
        dismiss(animated: true)
    }
}
