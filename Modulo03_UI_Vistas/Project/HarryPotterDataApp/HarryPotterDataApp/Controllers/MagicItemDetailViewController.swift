//
//  MagicItemDetailViewController.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation
import UIKit

class MagicItemDetailViewController: UIViewController {
    private let item: MagicItem
    
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
    
    init(item: MagicItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MinistryBackground") ?? .systemBackground
        title = item.categoryDisplayName
        navigationItem.largeTitleDisplayMode = .never
        
        setupLayout()
        populateData()
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
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    private func populateData() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: item.imageName) ?? UIImage(systemName: "sparkles")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = UIColor(named: "MinistryChip") ?? .systemGray5
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        contentStack.addArrangedSubview(imageView)
        
        let nameLabel = UILabel()
        nameLabel.text = item.name
        nameLabel.font = .systemFont(ofSize: 26, weight: .bold)
        nameLabel.numberOfLines = 0
        contentStack.addArrangedSubview(nameLabel)
        
        var badges: [String] = []
        if item.isUnforgivable { badges.append("Imperdonable") }
        if item.isHorcrux { badges.append("Horrocrux") }
        if item.isRestricted { badges.append("Acceso restringido") }
        
        if !badges.isEmpty {
            let badgeStack = UIStackView()
            badgeStack.axis = .horizontal
            badgeStack.spacing = 8
            badgeStack.distribution = .fillProportionally
            
            for badgeText in badges {
                badgeStack.addArrangedSubview(makeBadgeView(text: badgeText))
            }
            contentStack.addArrangedSubview(badgeStack)
        }
        
        var rows: [(String, String)] = [
            ("Categoría", item.categoryDisplayName),
            (item.detailLabel, item.subtype),
            ("Uso principal", item.usage)
        ]
        
        if let difficulty = item.difficultyDisplayName, !difficulty.isEmpty {
            rows.append(("Dificultad", difficulty))
        }
        
        rows.append(("Nivel de peligro", item.dangerDisplayName))
        
        if let incantation = item.incantation, !incantation.isEmpty {
            rows.append(("Fórmula", incantation))
        }
        
        contentStack.addArrangedSubview(makeCard(rows: rows))
        contentStack.addArrangedSubview(makeTextSection(title: "Descripción completa", body: item.description))
        
        if !item.precautions.isEmpty {
            contentStack.addArrangedSubview(makeTextSection(title: "Precauciones y observaciones", body: item.precautions))
        }
    }
    
    private func makeBadgeView(text: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(named: "MinistryDangerSurface") ?? UIColor.systemRed.withAlphaComponent(0.15)
        container.layer.cornerRadius = 8
        container.layer.borderWidth = 1
        container.layer.borderColor = (UIColor(named: "MinistryDanger") ?? .systemRed).cgColor
        
        let label = UILabel()
        label.text = text.uppercased()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(named: "MinistryDanger") ?? .systemRed
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
        ])
        return container
    }
    
    private func makeCard(rows: [(String, String)]) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(named: "MinistrySurface") ?? .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.layer.borderWidth = 1
        card.layer.borderColor = (UIColor(named: "MinistrySeparator") ?? .separator).cgColor
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for (title, value) in rows {
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 8
            
            let titleLbl = UILabel()
            titleLbl.text = title
            titleLbl.font = .systemFont(ofSize: 14, weight: .semibold)
            titleLbl.textColor = UIColor(named: "MinistrySecondary") ?? .secondaryLabel
            
            let valueLbl = UILabel()
            valueLbl.text = value
            valueLbl.font = .systemFont(ofSize: 14, weight: .medium)
            valueLbl.textAlignment = .right
            valueLbl.numberOfLines = 0
            
            row.addArrangedSubview(titleLbl)
            row.addArrangedSubview(valueLbl)
            stack.addArrangedSubview(row)
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
    
    private func makeTextSection(title: String, body: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(named: "MinistrySurface") ?? .secondarySystemBackground
        card.layer.cornerRadius = 12
        card.layer.borderWidth = 1
        card.layer.borderColor = (UIColor(named: "MinistrySeparator") ?? .separator).cgColor
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = .systemFont(ofSize: 16, weight: .bold)
        
        let bodyLbl = UILabel()
        bodyLbl.text = body
        bodyLbl.font = .systemFont(ofSize: 15, weight: .regular)
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
}
