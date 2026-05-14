//
//  CharacterDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import Combine

@MainActor
final class CharacterDetailViewModel: ObservableObject {
    
    @Published var watchedEpisodes: Set<Int> = []
    @Published var character: Character
    @Published var isLoading = true
    private let episodeService = EpisodeService()
    
    init(character: Character) {
        self.character = character
    }
    
    func fetchEpisodes() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            var fetchedEpisodes:
            [Episode] = []
            for episode in character.episodes {
                let dto = try await episodeService
                    .fetchEpisode(from: "https://rickandmortyapi.com/api/episode/\(episode.id)")
                let savedEpisode = character.episodes.first {
                    $0.id == dto.id
                }
                
                let episodeModel = Episode(
                    id: dto.id,
                    name: dto.name,
                    code: dto.episode,
                    isWatched: savedEpisode?.isWatched ?? false)
                fetchedEpisodes.append(episodeModel)
            }
            character.episodes = fetchedEpisodes
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func toggleEpisodeWatched(_ episode: Episode) {
        guard let index = character.episodes.firstIndex(where: {$0.id == episode.id})
        else {
            return
        }
        character.episodes[index].isWatched.toggle()
    }
    
    func isEpisodeWatched(_ episodeId: Int) -> Bool {
        watchedEpisodes.contains(episodeId)
    }
}
