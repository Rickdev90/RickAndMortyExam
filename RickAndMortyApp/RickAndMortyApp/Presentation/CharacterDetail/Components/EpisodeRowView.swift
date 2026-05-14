//
//  EpisodeRowView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

struct EpisodeRowView: View {
    
    let title: String
    let isWatched: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(
                    systemName:
                        isWatched
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .foregroundStyle(
                    isWatched
                    ? .green
                    : .gray
                )
                Text(title)
                Spacer()
            }
            .padding()
            .background(
                Color.gray.opacity(0.1)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
        }
        .buttonStyle(.plain)
    }
}
