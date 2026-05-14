//
//  CharacterCardView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import SwiftUI
import Kingfisher

struct CharacterCardView: View {
    
    let character: Character
    var body: some View {
        
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            
            KFImage(URL(string: character.image))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFill()
            .frame(height: 180)
            .frame(maxWidth: .infinity)
            .clipped()
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                Text(character.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(character.species)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack {
                    Circle()
                        .fill(
                            character.status == "Alive" ? .green : .red
                        )
                        .frame(width: 8, height: 8)
                    Text(character.status)
                        .font(.caption)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
