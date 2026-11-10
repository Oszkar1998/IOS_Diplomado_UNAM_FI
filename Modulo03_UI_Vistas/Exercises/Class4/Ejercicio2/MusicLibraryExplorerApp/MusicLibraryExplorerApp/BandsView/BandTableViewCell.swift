//
//  BandTableViewCell.swift
//  MusicLibraryExplorerApp
//
//  Created by Oscar Cortes Calderon  on 30/10/26.
//

import Foundation
import UIKit

class BandTableViewCell: UITableViewCell {

    // Errores tipograficos
    static let reuseIdentifier = "BandTableViewCell"

    // Visualizacion de la imagen
    private let bandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Visuaklizacion del nombre
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Inicializador de la celda
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Interfaz
    private func setupView() {
        accessoryType = .disclosureIndicator // Muestra la flecha '>' a la derecha
        
        contentView.addSubview(bandImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            // Restricciones para la imagen
            bandImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bandImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bandImageView.widthAnchor.constraint(equalToConstant: 55),
            bandImageView.heightAnchor.constraint(equalToConstant: 55),

            // Restricciones para el nombre
            nameLabel.leadingAnchor.constraint(equalTo: bandImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with band: Band) {
        nameLabel.text = band.name
        bandImageView.image = UIImage(named: band.imageName) ?? UIImage(systemName: "music.note")
    }
}
