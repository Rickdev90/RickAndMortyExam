//
//  FavoritesView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject private var favoritesPersistence: FavoritesPersistence
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack( alignment: .leading,spacing: 24) {
                    if favoritesPersistence.favorites.isEmpty {
                        emptyState
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favoritesPersistence.favorites, id: \.id) { entity in
                                let character = CharacterEntityMapper.toDomain(
                                        from: entity
                                    )
                                NavigationLink {CharacterDetailView(character: character)}
                                label: {
                                    CharacterCardView(character: character)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
        }
    }
}


private extension FavoritesView {
    
    var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .font(.system(size: 50))
                .foregroundStyle(.gray)
            Text("No favorites yet")
                .font(.headline)
            Text(
                "Characters you mark as favorite will appear here."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding(.top, 100)
    }
}
