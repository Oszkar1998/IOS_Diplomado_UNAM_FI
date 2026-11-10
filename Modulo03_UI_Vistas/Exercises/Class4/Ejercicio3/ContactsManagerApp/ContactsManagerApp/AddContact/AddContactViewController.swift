//
//  AddContactViewController.swift
//  ContactsManagerApp
//
//  Created by Oscar Cortes Calderon  on 31/10/26.
//

import Foundation
import UIKit

// Notifica al ContactsListViewController cuando se guarde un contacto
protocol AddContactViewControllerDelegate: AnyObject {
    func didSaveContact(_ contact: Contact)
}

class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactViewControllerDelegate?
    
    // Nombre
    private let firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nombre"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Apellido
    private let lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Apellido"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Teléfono
    private let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Teléfono"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .phonePad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nuevo Contacto"
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupLayout()
    }
    
    // Configuración de los botones Cancelar y Guardar
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapSave)
        )
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, phoneTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // Cancelar
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    // Guardar
    @objc private func didTapSave() {
        let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if firstName.isEmpty || phone.isEmpty {
            showAlert(title: "Campos Requeridos", message: "El nombre y el teléfono son obligatorios.")
            return
        }
        
        // Se crea nuevo contacto y se notifica 
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phone)
        delegate?.didSaveContact(newContact)
        dismiss(animated: true)
    }
    
    // Alerta de validación
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}
