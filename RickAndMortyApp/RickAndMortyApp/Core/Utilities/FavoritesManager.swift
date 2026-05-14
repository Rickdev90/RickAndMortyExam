//
//  FavoritesManager.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import Combine

@MainActor
final class FavoritesManager: ObservableObject {
    @Published var favorites: [Character] = []
    
    func toggleFavorite(_ character: Character) {
        if isFavorite(character) {
            favorites.removeAll {
                $0.id == character.id
            }
        } else {
            favorites.append(character)
        }
    }
    
    func isFavorite(_ character: Character) -> Bool {
        favorites.contains {
            $0.id == character.id
        }
    }
}
