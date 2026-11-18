//
//  CountryDetailViewController.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation
import UIKit

protocol CountryDetailViewControllerDelegate: AnyObject {
    func didSelectCurrency(_ currency: Currency)
}

class CountryDetailViewController: UIViewController {
    
    weak var delegate: CountryDetailViewControllerDelegate?
    private let viewModel: CountryDetailViewModel
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let currencyRowButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .secondarySystemBackground
        config.baseForegroundColor = .label
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 14)
        
        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let statesTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureData()
    }
    
    private func setupView() {
        title = viewModel.countryName
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissModal)
        )
        
        let infoStack = UIStackView(arrangedSubviews: [capitalLabel, languageLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 6
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(flagImageView)
        view.addSubview(infoStack)
        view.addSubview(currencyRowButton)
        view.addSubview(statesTableView)
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            flagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: 200),
            flagImageView.heightAnchor.constraint(equalToConstant: 120),
            
            infoStack.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 16),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            currencyRowButton.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: 14),
            currencyRowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currencyRowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statesTableView.topAnchor.constraint(equalTo: currencyRowButton.bottomAnchor, constant: 10),
            statesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        currencyRowButton.addTarget(self, action: #selector(didTapCurrency), for: .touchUpInside)
        
        statesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StateCell")
        statesTableView.dataSource = self
        statesTableView.delegate = self
    }
    
    private func configureData() {
        flagImageView.image = UIImage(named: viewModel.flagName)
        capitalLabel.text = "Capital: \(viewModel.capital)"
        languageLabel.text = "Language: \(viewModel.language)"
        
        var config = currencyRowButton.configuration
        config?.title = "Currency: \(viewModel.currencyText)"
        config?.subtitle = "Toca para ir al conversor"
        config?.image = UIImage(systemName: "arrow.left.arrow.right.circle.fill")
        config?.imagePlacement = .trailing
        config?.imagePadding = 8
        currencyRowButton.configuration = config
    }
    
    @objc private func dismissModal() {
        dismiss(animated: true)
    }
    
    @objc private func didTapCurrency() {
        let selectedCurrency = viewModel.currency
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectCurrency(selectedCurrency)
        }
    }
}

extension CountryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfStates()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "States"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = viewModel.getState(at: indexPath).nombre
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension CountryDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let state = viewModel.getState(at: indexPath)
        let pointsVC = PointsOfInterestViewController(state: state)
        navigationController?.pushViewController(pointsVC, animated: true)
    }
}
