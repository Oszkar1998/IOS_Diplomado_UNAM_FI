//
//  ArchivoMagicoViewModel.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

class ArchivoMagicoViewModel {
    private let allSections: [MagicSection]
    private(set) var visibleSections: [MagicSection] = []
    
    var searchText: String = "" {
        didSet { applySearch() }
    }
    
    var onDataUpdated: (() -> Void)?
    
    init() {
        self.allSections = JSONDataService.shared.loadMagicSections()
        self.visibleSections = allSections
    }
    
    private func applySearch() {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).normalizedForSearch()
        
        if query.isEmpty {
            visibleSections = allSections
            onDataUpdated?()
            return
        }
        
        visibleSections = allSections.compactMap { section in
            let matchingItems = section.items.filter { item in
                let nameMatch = item.name.normalizedForSearch().contains(query)
                let typeMatch = item.subtype.normalizedForSearch().contains(query)
                let usageMatch = item.usage.normalizedForSearch().contains(query)
                return nameMatch || typeMatch || usageMatch
            }
            
            guard !matchingItems.isEmpty else { return nil }
            return MagicSection(id: section.id, title: section.title, items: matchingItems)
        }
        
        onDataUpdated?()
    }
}
