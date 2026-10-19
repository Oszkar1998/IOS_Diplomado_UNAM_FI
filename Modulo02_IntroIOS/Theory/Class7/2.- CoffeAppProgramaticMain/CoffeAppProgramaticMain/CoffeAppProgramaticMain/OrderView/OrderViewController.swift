//
//  OrderViewController.swift
//  CoffeAppProgramaticMain
//
//  Created by Luis Fernando Gutierrez Orozpe on 09/10/26.
//

import UIKit

class OrderViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coffe App"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clientNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clientNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Introduce el nombre del cliente"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let clientNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let coffeTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tipo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coffeTypeSegmentedControl: UISegmentedControl = {
        let options = ["Expresso","Latte", "Cappuccino"]
        let segmented = UISegmentedControl(items: options)
        segmented.selectedSegmentIndex = 0
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    private let coffeTypeStackView: UIStackView = {
        let coffeTypeStack = UIStackView()
        coffeTypeStack.axis = .vertical
        coffeTypeStack.spacing = 8
        coffeTypeStack.distribution = .fill
        coffeTypeStack.alignment = .fill
        coffeTypeStack.translatesAutoresizingMaskIntoConstraints = false
        return coffeTypeStack
    }()
    
    private let sugarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Azúcar"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sugarAmountSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 5
        slider.value = 1
        slider.minimumValueImage = UIImage(systemName: "minus")
        slider.maximumValueImage = UIImage(systemName: "plus")
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let sugarAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sugarAmountStackView: UIStackView = {
        let sugarAmountStack = UIStackView()
        sugarAmountStack.axis = .horizontal
        sugarAmountStack.spacing = 8
        sugarAmountStack.distribution = .fillEqually
        sugarAmountStack.alignment = .fill
        sugarAmountStack.translatesAutoresizingMaskIntoConstraints = false
        return sugarAmountStack
    }()
    
    private let sugarStackView: UIStackView = {
        let sugarStack = UIStackView()
        sugarStack.axis = .vertical
        sugarStack.spacing = 8
        sugarStack.distribution = .fill
        sugarStack.alignment = .fill
        sugarStack.translatesAutoresizingMaskIntoConstraints = false
        return sugarStack
    }()
    
    private let orderButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Ordenar"
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialValues()
        setupHerarchy()
        setupConstraints()
        setupActions()
    }
    
    private func setupInitialValues() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func setupHerarchy() {
        view.addSubview(titleLabel)
        
        clientNameStackView.addArrangedSubview(clientNameLabel)
        clientNameStackView.addArrangedSubview(clientNameTextField)
        view.addSubview(clientNameStackView)
        
        coffeTypeStackView.addArrangedSubview(coffeTypeLabel)
        coffeTypeStackView.addArrangedSubview(coffeTypeSegmentedControl)
        view.addSubview(coffeTypeStackView)
        
        sugarAmountStackView.addArrangedSubview(sugarTitleLabel)
        sugarAmountStackView.addArrangedSubview(sugarAmountLabel)
        sugarStackView.addArrangedSubview(sugarAmountStackView)
        sugarStackView.addArrangedSubview(sugarAmountSlider)
        view.addSubview(sugarStackView)
        
        view.addSubview(orderButton)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            
            clientNameStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            clientNameStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            clientNameStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
            coffeTypeStackView.topAnchor.constraint(equalTo: clientNameStackView.bottomAnchor, constant: 24),
            coffeTypeStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            coffeTypeStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
            sugarStackView.topAnchor.constraint(equalTo: coffeTypeStackView.bottomAnchor, constant: 24),
            sugarStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            sugarStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
            orderButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            orderButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            orderButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
        ])
    }
    
    private func setupActions() {
        orderButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        guard let ticketViewController = UIStoryboard(name: "TicketViewController", bundle: nil).instantiateViewController(withIdentifier: "TicketViewController") as? TicketViewController else { return }
        
        navigationController?.pushViewController(ticketViewController, animated: true)
    }
}
