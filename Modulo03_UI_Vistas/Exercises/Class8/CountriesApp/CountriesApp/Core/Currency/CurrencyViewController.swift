//
//  CurrencyViewController.swift
//  CountriesApp
//
//  Created by Adrian Monreal Aldrighetti on 17/11/26.
//

import Foundation
import UIKit

class CurrencyViewController: UIViewController {
    
    private let viewModel: CurrencyViewModel
    
    private let leftPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let rightPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let directionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let directionHintLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingresa cantidad (ej. 100)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let convertButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Convert"
        config.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        config.imagePadding = 8
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Resultado: --"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        syncPickersAndDirection()
    }
    
    private func setupView() {
        title = "Currency"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let pickersContainer = UIStackView(arrangedSubviews: [leftPicker, directionImageView, rightPicker])
        pickersContainer.axis = .horizontal
        pickersContainer.alignment = .center
        pickersContainer.distribution = .fill
        pickersContainer.spacing = 6
        pickersContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pickersContainer)
        view.addSubview(directionHintLabel)
        view.addSubview(amountTextField)
        view.addSubview(convertButton)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            pickersContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            pickersContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            pickersContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            pickersContainer.heightAnchor.constraint(equalToConstant: 160),
            
            directionImageView.widthAnchor.constraint(equalToConstant: 36),
            directionImageView.heightAnchor.constraint(equalToConstant: 36),
            leftPicker.widthAnchor.constraint(equalTo: rightPicker.widthAnchor),
            
            directionHintLabel.topAnchor.constraint(equalTo: pickersContainer.bottomAnchor, constant: 4),
            directionHintLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            directionHintLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            amountTextField.topAnchor.constraint(equalTo: directionHintLabel.bottomAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            amountTextField.heightAnchor.constraint(equalToConstant: 46),
            
            convertButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 16),
            convertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            convertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            convertButton.heightAnchor.constraint(equalToConstant: 48),
            
            resultLabel.topAnchor.constraint(equalTo: convertButton.bottomAnchor, constant: 28),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        leftPicker.dataSource = self
        leftPicker.delegate = self
        rightPicker.dataSource = self
        rightPicker.delegate = self
        amountTextField.delegate = self
        
        convertButton.addTarget(self, action: #selector(didTapConvert), for: .touchUpInside)
        
        let directionTap = UITapGestureRecognizer(target: self, action: #selector(didTapDirectionArrow))
        directionImageView.addGestureRecognizer(directionTap)
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissTap)
    }
    
    private func syncPickersAndDirection() {
        leftPicker.selectRow(viewModel.leftSelectedIndex, inComponent: 0, animated: false)
        rightPicker.selectRow(viewModel.rightSelectedIndex, inComponent: 0, animated: false)
        updateDirectionUI()
    }
    
    private func updateDirectionUI() {
        directionImageView.image = UIImage(systemName: viewModel.direction.symbolSystemName)
        directionHintLabel.text = viewModel.direction.descriptionText
    }
    
    func setPreselectedCurrency(_ currency: Currency) {
        guard let index = viewModel.selectSourceCurrency(currency) else { return }
        if isViewLoaded {
            leftPicker.selectRow(index, inComponent: 0, animated: true)
            updateDirectionUI()
            resultLabel.text = "Resultado: --"
            resultLabel.textColor = .label
        }
    }
    
    @objc private func didTapDirectionArrow() {
        viewModel.toggleDirection()
        updateDirectionUI()
    }
    
    @objc private func didTapConvert() {
        view.endEditing(true)
        switch viewModel.convert(amountText: amountTextField.text) {
        case .success(let formattedConversion):
            resultLabel.textColor = .label
            resultLabel.text = formattedConversion
        case .failure(let error):
            resultLabel.textColor = .systemRed
            resultLabel.text = error.localizedDescription
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CurrencyViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.getNumberOfCurrencies()
    }
}

extension CurrencyViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.getCurrencyTitle(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == leftPicker {
            viewModel.updateLeftSelection(row: row)
        } else {
            viewModel.updateRightSelection(row: row)
        }
        updateDirectionUI()
    }
}

extension CurrencyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Bloquea cualquier intento de ingresar o pegar el signo negativo "-"
        if string.contains("-") {
            return false
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.isEmpty { return true }
        
        // Evita múltiples puntos decimales
        let decimalSeparators = updatedText.filter { $0 == "." || $0 == "," }
        if decimalSeparators.count > 1 {
            return false
        }
        
        // Valida que solo sean dígitos o separador decimal
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.,")
        return string.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
    }
}
