//
//  CharacterDetailViewController.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    private let character: Character
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let characterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.backgroundColor = UIColor(named: "MinistryChip") ?? .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let favoriteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MinistryBackground") ?? .systemBackground
        title = "Expediente"
        navigationItem.largeTitleDisplayMode = .never
        
        setupLayout()
        populateData()
        updateFavoriteButton()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            characterImageView.heightAnchor.constraint(equalToConstant: 240),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }
    
    private func populateData() {
        characterImageView.image = UIImage(named: character.imageName) ?? UIImage(systemName: "person.fill")
        contentStack.addArrangedSubview(characterImageView)
        
        let nameLabel = UILabel()
        nameLabel.text = character.name
        nameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        nameLabel.numberOfLines = 0
        contentStack.addArrangedSubview(nameLabel)
        
        if let reward = character.reward {
            let rewardBanner = makeRewardCard(galleons: reward)
            contentStack.addArrangedSubview(rewardBanner)
        }
        
        let infoCard = makeInfoCard()
        contentStack.addArrangedSubview(infoCard)
        
        let descCard = makeDescriptionCard()
        contentStack.addArrangedSubview(descCard)
        
        contentStack.addArrangedSubview(favoriteButton)
    }
    
    private func makeRewardCard(galleons: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(named: "MinistryDangerSurface") ?? UIColor.systemRed.withAlphaComponent(0.15)
        container.layer.cornerRadius = 12
        container.layer.borderWidth = 1
        container.layer.borderColor = (UIColor(named: "MinistryDanger") ?? .systemRed).cgColor
        
        let label = UILabel()
        label.text = "SE BUSCA · Recompensa: \(galleons) galeones"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(named: "MinistryDanger") ?? .systemRed
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14)
        ])
        return container
    }
    
    private func makeInfoCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(named: "MinistrySurface") ?? .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.layer.borderWidth = 1
        card.layer.borderColor = (UIColor(named: "MinistrySeparator") ?? .separator).cgColor
        
        let rows: [(String, String)] = [
            ("Ocupación", character.occupation),
            ("Casa", character.houseDisplayName),
            ("Afiliación", character.affiliation),
            ("Estado del expediente", character.statusDisplayName)
        ]
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for (title, value) in rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fill
            rowStack.spacing = 8
            
            let titleLbl = UILabel()
            titleLbl.text = title
            titleLbl.font = .systemFont(ofSize: 14, weight: .semibold)
            titleLbl.textColor = UIColor(named: "MinistrySecondary") ?? .secondaryLabel
            
            let valueLbl = UILabel()
            valueLbl.text = value
            valueLbl.font = .systemFont(ofSize: 14, weight: .medium)
            valueLbl.textAlignment = .right
            valueLbl.numberOfLines = 0
            
            rowStack.addArrangedSubview(titleLbl)
            rowStack.addArrangedSubview(valueLbl)
            stack.addArrangedSubview(rowStack)
        }
        
        card.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -14),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 14),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -14)
        ])
        return card
    }
    
    private func makeDescriptionCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(named: "MinistrySurface") ?? .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.layer.borderWidth = 1
        card.layer.borderColor = (UIColor(named: "MinistrySeparator") ?? .separator).cgColor
        
        let titleLbl = UILabel()
        titleLbl.text = "Antecedentes"
        titleLbl.font = .systemFont(ofSize: 16, weight: .bold)
        
        let bodyLbl = UILabel()
        bodyLbl.text = character.description
        bodyLbl.font = .systemFont(ofSize: 15, weight: .regular)
        bodyLbl.textColor = .label
        bodyLbl.numberOfLines = 0
        
        let stack = UIStackView(arrangedSubviews: [titleLbl, bodyLbl])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -14),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 14),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -14)
        ])
        return card
    }
    
    private func updateFavoriteButton() {
        let isSaved = FavoritesService.shared.isFavorite(characterID: character.id)
        if isSaved {
            favoriteButton.setTitle("Quitar de guardados", for: .normal)
            favoriteButton.backgroundColor = UIColor(named: "MinistryDangerSurface") ?? UIColor.systemRed.withAlphaComponent(0.15)
            favoriteButton.setTitleColor(UIColor(named: "MinistryDanger") ?? .systemRed, for: .normal)
        } else {
            favoriteButton.setTitle("Guardar expediente", for: .normal)
            favoriteButton.backgroundColor = UIColor(named: "MinistryForest") ?? .systemGreen
            favoriteButton.setTitleColor(UIColor(named: "MinistryOnForest") ?? .white, for: .normal)
        }
    }
    
    @objc private func didTapFavorite() {
        FavoritesService.shared.toggleFavorite(characterID: character.id)
        updateFavoriteButton()
    }
}
