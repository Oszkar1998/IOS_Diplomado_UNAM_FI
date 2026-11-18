//
//  ExpedientesViewController.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation
import UIKit

class ExpedientesViewController: UIViewController {
    private let viewModel = ExpedientesViewModel()
    private var houseButtons: [HouseFilter: UIButton] = [:]
    
    private let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Buscar por nombre u ocupación"
        return sc
    }()
    
    private let filtersScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.canCancelContentTouches = true
        sv.delaysContentTouches = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let filtersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(named: "MinistrySecondary") ?? .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.keyboardDismissMode = .onDrag
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
        title = "Expedientes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSearch()
        setupFilters()
        setupTableView()
        setupEmptyState()
        bindViewModel()
        updateUI()
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupFilters() {
        view.addSubview(filtersScrollView)
        filtersScrollView.addSubview(filtersStackView)
        view.addSubview(countLabel)
        
        for filter in HouseFilter.allCases {
            var config = UIButton.Configuration.filled()
            config.title = filter.rawValue
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14)
            config.cornerStyle = .capsule
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .systemFont(ofSize: 13, weight: .semibold)
                return outgoing
            }
            
            let button = UIButton(configuration: config)
            button.addTarget(self, action: #selector(didTapHouseFilter(_:)), for: .touchUpInside)
            
            houseButtons[filter] = button
            filtersStackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            filtersScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            filtersScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filtersScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filtersScrollView.heightAnchor.constraint(equalToConstant: 36),
            
            filtersStackView.topAnchor.constraint(equalTo: filtersScrollView.topAnchor),
            filtersStackView.bottomAnchor.constraint(equalTo: filtersScrollView.bottomAnchor),
            filtersStackView.leadingAnchor.constraint(equalTo: filtersScrollView.leadingAnchor, constant: 16),
            filtersStackView.trailingAnchor.constraint(equalTo: filtersScrollView.trailingAnchor, constant: -16),
            filtersStackView.heightAnchor.constraint(equalTo: filtersScrollView.heightAnchor),
            
            countLabel.topAnchor.constraint(equalTo: filtersScrollView.bottomAnchor, constant: 8),
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupEmptyState() {
        view.addSubview(emptyStateView)
        
        let titleLbl = UILabel()
        titleLbl.text = "Sin expedientes coincidentes"
        titleLbl.font = .systemFont(ofSize: 18, weight: .bold)
        titleLbl.textAlignment = .center
        
        let subtitleLbl = UILabel()
        subtitleLbl.text = "No se encontraron registros con los filtros actuales."
        subtitleLbl.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLbl.textColor = UIColor(named: "MinistrySecondary") ?? .secondaryLabel
        subtitleLbl.textAlignment = .center
        subtitleLbl.numberOfLines = 0
        
        var resetConfig = UIButton.Configuration.filled()
        resetConfig.title = "Restablecer filtros"
        resetConfig.baseBackgroundColor = UIColor(named: "MinistryForest") ?? .systemGreen
        resetConfig.baseForegroundColor = UIColor(named: "MinistryOnForest") ?? .white
        resetConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18)
        resetConfig.cornerStyle = .medium
        resetConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 15, weight: .semibold)
            return outgoing
        }
                
        let resetBtn = UIButton(configuration: resetConfig)
        resetBtn.addTarget(self, action: #selector(didTapResetFilters), for: .touchUpInside)
           
        
        let stack = UIStackView(arrangedSubviews: [titleLbl, subtitleLbl, resetBtn])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        emptyStateView.addSubview(stack)
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
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
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        for (filter, button) in houseButtons {
            let isSelected = (filter == viewModel.selectedHouse)
            var config = button.configuration
            config?.baseBackgroundColor = isSelected
                ? (UIColor(named: "MinistryForest") ?? .systemGreen)
                : (UIColor(named: "MinistryChip") ?? .systemGray5)
            config?.baseForegroundColor = isSelected
                ? (UIColor(named: "MinistryOnForest") ?? .white)
                : .label
            button.configuration = config
        }
        
        let count = viewModel.filteredCharacters.count
        countLabel.text = count == 1 ? "1 expediente" : "\(count) expedientes"
        emptyStateView.isHidden = count > 0
        tableView.reloadData()
    }
    
    @objc private func didTapHouseFilter(_ sender: UIButton) {
        guard let title = sender.configuration?.title ?? sender.title(for: .normal),
              let filter = HouseFilter(rawValue: title) else { return }
        viewModel.selectedHouse = filter
    }
    
    @objc private func didTapResetFilters() {
        searchController.searchBar.text = ""
        viewModel.resetFilters()
    }
}

extension ExpedientesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text ?? ""
    }
}

extension ExpedientesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.filteredCharacters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.filteredCharacters[indexPath.row]
        let detailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
