//
//  FilterChipView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

struct FilterChipView: View {
    
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.caption)
                }
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background( isSelected ? Color.white: Color.gray.opacity(0.50))
            .foregroundStyle(isSelected ? .black : .white)
            .clipShape(Capsule())
        }
    }
}
