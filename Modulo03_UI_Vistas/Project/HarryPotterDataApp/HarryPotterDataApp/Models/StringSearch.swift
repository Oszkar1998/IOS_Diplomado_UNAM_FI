//
//  StringSearch.swift
//  HarryPotterDataApp
//
//  Created by Oscar Cortes Calderon  on 14/11/26.
//

import Foundation

extension String {
    func normalizedForSearch() -> String {
        return self.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
    }
}
