//
//  ContactTableViewCell.swift
//  ContactsManagerApp
//
//  Created by Oscar Cortes Calderon  on 31/10/26.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ContactTableViewCell"
    
    // SF Symbols
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Nombre del contacto
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Número telefónico
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Inicializador programático
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Visualización y reglas de Auto Layout
    private func setupView() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(avatarImageView)
        
        // StackView vertical -> organiza el nombre arriba y el teléfono abajo
        let stackView = UIStackView(arrangedSubviews: [nameLabel, phoneLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            // Avatar (40x40 px)
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // StackView de textos
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // Datos del modelo `Contact`
    func configure(with contact: Contact) {
        nameLabel.text = contact.fullName
        phoneLabel.text = contact.phoneNumber
    }
}
