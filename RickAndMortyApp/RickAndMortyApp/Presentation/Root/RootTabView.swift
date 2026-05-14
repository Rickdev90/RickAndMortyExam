//
//  RootTabView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

struct RootTabView: View {
    
    @State private var selectedTab = 0
    @State private var previousTab = 0
    @State private var showFavorites = false
    @State private var charactersPath = NavigationPath()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CharactersView(path: $charactersPath)
            .id(selectedTab == 0 ? UUID() : UUID())
            .tabItem {
                Image(systemName:"person.3.fill")
                Text("Characters")
            }
            .tag(0)
            Group {
                if showFavorites {
                    FavoritesView()
                } else {
                    Color.clear
                }
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
            .tag(1)
        }
        .onChange(of: selectedTab) { newValue in
            if newValue == 0 {
                charactersPath =
                NavigationPath()
            }
            if newValue == 1 {
                showFavorites = false
                authenticateFavorites()
            }
        }
    }
}

private extension RootTabView {
    
    func authenticateFavorites() {
        BiometricAuthManager.shared.authenticate { success in
                if success {
                    showFavorites = true
                } else {
                    selectedTab = 0
                }
            }
    }
}
