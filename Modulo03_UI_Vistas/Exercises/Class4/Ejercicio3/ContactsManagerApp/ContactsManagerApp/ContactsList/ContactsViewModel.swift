//
//  ContactsViewModel.swift
//  ContactsManagerApp
//
//  Created by Oscar Cortes Calderon  on 31/10/26.
//

import Foundation
import UIKit

class ContactsViewModel {
    
    // Evita modificarlas desde fuera
    private(set) var allContacts: [Contact] = []
    private(set) var filteredContacts: [Contact] = []
    private(set) var currentSearchQuery: String = ""
    
    init() {
        // Contactos iniciales de prueba
        let initialContacts = [
            Contact(firstName: "Alfonso", lastName: "Martinez", phoneNumber: "5512345678"),
            Contact(firstName: "Adrian", lastName: "Aldrighetti", phoneNumber: "5587654321"),
            Contact(firstName: "Oscar", lastName: "Cortes", phoneNumber: "5544332211")
        ]
        
        for contact in initialContacts {
            addContact(contact)
        }
    }
        
    // Cantidad de filas
    func getNumberOfRows() -> Int {
        return filteredContacts.count
    }
    
    func getContact(at indexPath: IndexPath) -> Contact {
        return filteredContacts[indexPath.row]
    }
    
    // Verifica si la lista está vacía
    func isListEmpty() -> Bool {
        return allContacts.isEmpty
    }
    
    // Verifica si hay una búsqueda activa que no arrojó resultados
    func isSearchActiveAndEmpty() -> Bool {
        return !allContacts.isEmpty && filteredContacts.isEmpty && !currentSearchQuery.isEmpty
    }
        
    // Agrega un nuevo contacto, ordena y actualiza la lista filtrada
    func addContact(_ contact: Contact) {
        allContacts.append(contact)
        sortContacts()
        filterContacts(with: currentSearchQuery)
    }
    
    // Elimina un contacto de la lista
    func deleteContact(at indexPath: IndexPath) {
        let contactToDelete = filteredContacts[indexPath.row]
        allContacts.removeAll { $0.id == contactToDelete.id }
        filterContacts(with: currentSearchQuery)
    }
    
    // Filtra contactos por nombre, apellido o teléfono
    func filterContacts(with query: String) {
        currentSearchQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if currentSearchQuery.isEmpty {
            filteredContacts = allContacts
        } else {
            filteredContacts = allContacts.filter { contact in
                contact.firstName.localizedStandardContains(currentSearchQuery) ||
                (contact.lastName?.localizedStandardContains(currentSearchQuery) ?? false) ||
                contact.phoneNumber.localizedStandardContains(currentSearchQuery)
            }
        }
    }
    
    // Orden alfabético por nombre y luego por apellido
    private func sortContacts() {
        allContacts.sort { (c1, c2) -> Bool in
            if c1.firstName.localizedCaseInsensitiveCompare(c2.firstName) == .orderedSame {
                return (c1.lastName ?? "").localizedCaseInsensitiveCompare(c2.lastName ?? "") == .orderedAscending
            }
            return c1.firstName.localizedCaseInsensitiveCompare(c2.firstName) == .orderedAscending
        }
    }
}
