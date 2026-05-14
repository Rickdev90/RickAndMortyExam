//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI
import MapKit
import Kingfisher

struct CharacterDetailView: View {

    @StateObject private var viewModel: CharacterDetailViewModel
    @EnvironmentObject private var favoritesPersistence: FavoritesPersistence

    init(character: Character) {
        _viewModel = StateObject( wrappedValue: CharacterDetailViewModel(character: character))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 20) {
                    ProgressView()
                    Text("Loading character...")
                        .foregroundStyle(.secondary)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )

            } else {
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: 24
                    ) {
                        headerImage
                        infoSection
                        actionsSection
                        episodesSection
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(
            viewModel.character.name
        )
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if let updatedCharacter = favoritesPersistence.getCharacter(by: viewModel.character.id) {
                viewModel.character = updatedCharacter
            }
            await viewModel.fetchEpisodes()
        }
    }
}


private extension CharacterDetailView {
    var headerImage: some View {
        KFImage(URL(string:viewModel.character.image))
        .placeholder {
            ProgressView()
        }
        .resizable()
        .scaledToFill()
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    var infoSection: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            Text(
                viewModel.character.name
            )
            .font(.largeTitle)
            .fontWeight(.bold)

            InfoRowView(
                title: "Status",
                value: viewModel.character.status
            )

            InfoRowView(
                title: "Species",
                value: viewModel.character.species
            )

            InfoRowView(
                title: "Gender",
                value: viewModel.character.gender
            )

            InfoRowView(
                title: "Origin",
                value:viewModel.character.originName
            )

            InfoRowView(
                title: "Location",
                value:viewModel.character.locationName
            )
        }
    }

    var actionsSection: some View {

        VStack(spacing: 12) {
            FavoriteButton(isFavorite: favoritesPersistence.isFavorite(viewModel.character)) {
                favoritesPersistence.toggleFavorite(character:viewModel.character)}

            NavigationLink {
                CharacterMapView(characterName: viewModel.character.name,
                    coordinate:
                        coordinateForCharacter(id: viewModel.character.id))
            } label: {
                HStack {
                    Image(systemName: "map")
                    Text("View on Map")
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.15))
                .foregroundStyle(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16)
                )
            }
        }
    }

    var episodesSection: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            Text("Episodes")
                .font(.title2)
                .fontWeight(.bold)
            LazyVStack(
                spacing: 12
            ) {
                ForEach(viewModel.character.episodes) { episode in
                    EpisodeRowView(
                        title: "\(episode.code) - \(episode.name)",
                        isWatched: episode.isWatched
                    ) {
                        viewModel.toggleEpisodeWatched(episode)
                        favoritesPersistence
                            .updateEpisodeWatched(
                                characterID:
                                    viewModel.character.id,
                                episodeID:
                                    episode.id,
                                isWatched:
                                    !episode.isWatched
                            )
                    }
                }
            }
        }
    }
}

func coordinateForCharacter(id: Int) -> CLLocationCoordinate2D {
    let coordinates = [
        CLLocationCoordinate2D(
            latitude: 19.4326,
            longitude: -99.1332
        ),
        CLLocationCoordinate2D(
            latitude: 20.6597,
            longitude: -103.3496
        ),
        CLLocationCoordinate2D(
            latitude: 25.6866,
            longitude: -100.3161
        ),
        CLLocationCoordinate2D(
            latitude: 40.7128,
            longitude: -74.0060
        ),
        CLLocationCoordinate2D(
            latitude: 34.0522,
            longitude: -118.2437
        ),
        CLLocationCoordinate2D(
            latitude: 48.8566,
            longitude: 2.3522
        ),
        CLLocationCoordinate2D(
            latitude: 35.6762,
            longitude: 139.6503
        )
    ]

    return coordinates[id % coordinates.count]
}
