//
//  GuardadosViewController.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation
import UIKit

class GuardadosViewController: UIViewController {
    private let viewModel = GuardadosViewModel()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let emptyStateView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MinistryBackground") ?? .systemBackground
        title = "Guardados"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupEmptyState()
        bindViewModel()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoritesChanged),
            name: .favoritesDidChange,
            object: nil
        )
        
        viewModel.reloadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadFavorites()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupEmptyState() {
        view.addSubview(emptyStateView)
        
        let titleLbl = UILabel()
        titleLbl.text = "Sin expedientes guardados"
        titleLbl.font = .systemFont(ofSize: 18, weight: .bold)
        titleLbl.textAlignment = .center
        
        let subtitleLbl = UILabel()
        subtitleLbl.text = "Todavía no hay expedientes guardados en tu lista de favoritos."
        subtitleLbl.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLbl.textColor = UIColor(named: "MinistrySecondary") ?? .secondaryLabel
        subtitleLbl.textAlignment = .center
        subtitleLbl.numberOfLines = 0
        
        var config = UIButton.Configuration.filled()
        config.title = "Explorar expedientes"
        config.baseBackgroundColor = UIColor(named: "MinistryForest") ?? .systemGreen
        config.baseForegroundColor = UIColor(named: "MinistryOnForest") ?? .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18)
        config.cornerStyle = .medium
        
        let exploreBtn = UIButton(configuration: config)
        exploreBtn.addTarget(self, action: #selector(didTapExplore), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLbl, subtitleLbl, exploreBtn])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        emptyStateView.addSubview(stack)
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            stack.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            self.emptyStateView.isHidden = !self.viewModel.savedCharacters.isEmpty
            self.tableView.reloadData()
        }
    }
    
    @objc private func handleFavoritesChanged() {
        viewModel.reloadFavorites()
    }
    
    @objc private func didTapExplore() {
        tabBarController?.selectedIndex = 0
    }
}

extension GuardadosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.savedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.savedCharacters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.savedCharacters[indexPath.row]
        let detailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let character = viewModel.savedCharacters[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] _, _, completionHandler in
            let alert = UIAlertController(
                title: "Eliminar expediente",
                message: "¿Deseas quitar a \(character.name) de tus guardados?",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                completionHandler(false)
            })
            
            alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive) { _ in
                self?.viewModel.removeFavorite(at: indexPath.row)
                completionHandler(true)
            })
            
            self?.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
