//
//  Contact.swift
//  ContactsManagerApp
//
//  Created by Oscar Cortes Calderon  on 31/10/26.
//

import Foundation

struct Contact: Identifiable {
    let id: UUID
    var firstName: String
    var lastName: String?
    var phoneNumber: String
    
    // Limpieza de espacios sobrantes al inicio y final
    init(id: UUID = UUID(), firstName: String, lastName: String? = nil, phoneNumber: String) {
        self.id = id
        self.firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lastName = lastName?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.phoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Obtiene el nombre completo
    var fullName: String {
        if let lastName = lastName, !lastName.isEmpty {
            return "\(firstName) \(lastName)"
        }
        return firstName
    }
}
