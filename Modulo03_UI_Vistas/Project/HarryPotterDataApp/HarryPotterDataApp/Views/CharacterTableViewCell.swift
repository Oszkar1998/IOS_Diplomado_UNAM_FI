//
//  CharacterTableViewCell.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation
import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MinistrySurface") ?? .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = (UIColor(named: "MinistrySeparator") ?? .separator).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.backgroundColor = UIColor(named: "MinistryChip") ?? .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let occupationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "MinistrySecondary") ?? .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let houseBadgeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "MinistryForest") ?? .systemGreen
        return label
    }()
    
    private let wantedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MinistryDangerSurface") ?? UIColor.systemRed.withAlphaComponent(0.15)
        view.layer.cornerRadius = 6
        view.isHidden = true
        return view
    }()
    
    private let wantedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(named: "MinistryDanger") ?? .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(cardView)
        cardView.addSubview(characterImageView)
        
        wantedContainer.addSubview(wantedLabel)
        NSLayoutConstraint.activate([
            wantedLabel.topAnchor.constraint(equalTo: wantedContainer.topAnchor, constant: 4),
            wantedLabel.bottomAnchor.constraint(equalTo: wantedContainer.bottomAnchor, constant: -4),
            wantedLabel.leadingAnchor.constraint(equalTo: wantedContainer.leadingAnchor, constant: 8),
            wantedLabel.trailingAnchor.constraint(equalTo: wantedContainer.trailingAnchor, constant: -8)
        ])
        
        let infoStack = UIStackView(arrangedSubviews: [nameLabel, occupationLabel, houseBadgeLabel, wantedContainer])
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.spacing = 4
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            characterImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            characterImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 68),
            characterImageView.heightAnchor.constraint(equalToConstant: 68),
            characterImageView.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor, constant: 12),
            characterImageView.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12),
            
            infoStack.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 12),
            infoStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            infoStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            infoStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        occupationLabel.text = character.occupation
        houseBadgeLabel.text = "Casa: \(character.houseDisplayName)"
        characterImageView.image = UIImage(named: character.imageName) ?? UIImage(systemName: "person.fill")
        
        if let reward = character.reward {
            wantedContainer.isHidden = false
            wantedLabel.text = "SE BUSCA · \(reward) galeones"
        } else {
            wantedContainer.isHidden = true
            wantedLabel.text = nil
        }
    }
}
