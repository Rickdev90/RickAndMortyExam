//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

@main
struct RickAndMortyApp: App {

    @StateObject
    private var favoritesPersistence =
    FavoritesPersistence()

    var body: some Scene {

        WindowGroup {

            RootTabView()
                .environmentObject(
                    favoritesPersistence
                )
        }
    }
}
