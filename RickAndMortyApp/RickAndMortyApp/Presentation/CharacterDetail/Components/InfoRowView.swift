//
//  InfoRowView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

struct InfoRowView: View {

    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}
