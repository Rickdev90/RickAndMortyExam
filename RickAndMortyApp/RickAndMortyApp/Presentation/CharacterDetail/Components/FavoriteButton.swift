//
//  FavoriteButton.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

struct FavoriteButton: View {

    let isFavorite: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {

            HStack {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                Text(isFavorite ? "Favorite" : "Add Favorite")
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isFavorite ? Color.red.opacity(0.2) : Color.gray.opacity(0.15)
            )
            .foregroundStyle(isFavorite ? .red : .primary
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("Favorite")
    }
}
