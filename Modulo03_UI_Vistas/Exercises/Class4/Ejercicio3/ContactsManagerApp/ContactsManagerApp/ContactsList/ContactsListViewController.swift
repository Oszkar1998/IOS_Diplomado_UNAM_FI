//
//  ContactsListViewController.swift
//  ContactsManagerApp
//
//  Created by Oscar Cortes Calderon  on 31/10/26.
//

import Foundation
import UIKit

class ContactsListViewController: UIViewController {

    private let viewModel = ContactsViewModel()
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    // Mensajes de estado vacío
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
        setupEmptyStateLabel()
        updateUI()
    }

    // Bbotón +
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddContact)
        )
    }

    // UISearchBar
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Buscar contacto..."
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
    }

    // Programática del UITableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.reuseIdentifier)
    }
    
    // Estado vacío
    private func setupEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func updateUI() {
        tableView.reloadData()
        
        if viewModel.isListEmpty() {
            emptyStateLabel.text = "No tienes contactos guardados."
            emptyStateLabel.isHidden = false
        } else if viewModel.isSearchActiveAndEmpty() {
            emptyStateLabel.text = "No se encontraron contactos para tu búsqueda."
            emptyStateLabel.isHidden = false
        } else {
            emptyStateLabel.isHidden = true
        }
    }

    // Abre el formulario
    @objc private func didTapAddContact() {
        let addVC = AddContactViewController()
        addVC.delegate = self
        let navContainer = UINavigationController(rootViewController: addVC)
        present(navContainer, animated: true)
    }
}

extension ContactsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ContactTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        
        // ViewModel
        let contact = viewModel.getContact(at: indexPath)
        cell.configure(with: contact)
        return cell
    }

    // Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = viewModel.getContact(at: indexPath)
            
            let alert = UIAlertController(
                title: "Eliminar contacto",
                message: "¿Deseas eliminar a \(contact.fullName)?",
                preferredStyle: .actionSheet
            )
            
            let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { [weak self] _ in
                self?.viewModel.deleteContact(at: indexPath)
                self?.updateUI()
            }
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

// Búsqueda en tiempo real
extension ContactsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterContacts(with: searchText)
        updateUI()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filterContacts(with: "")
        updateUI()
        searchBar.resignFirstResponder()
    }
}

// Recepción de nuevos contactos
extension ContactsListViewController: AddContactViewControllerDelegate {
    
    func didSaveContact(_ contact: Contact) {
        viewModel.addContact(contact)
        searchBar.text = "" // Limpia la búsqueda activa según el PDF
        updateUI()
    }
}
