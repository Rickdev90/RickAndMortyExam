//
//  FavoritesPersistence.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import CoreData
import Combine


@MainActor
final class FavoritesPersistence:
    ObservableObject {
    
    private let context = PersistenceController.shared.container.viewContext
    @Published var favorites: [CharacterEntity] = []
    
    init() {
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let request = CharacterEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "isFavorite == YES"
        )
        do {
            favorites =
            try context.fetch(request)
        } catch {
            print(
                error.localizedDescription
            )
        }
    }
    
    func updateEpisodeWatched(
        characterID: Int,
        episodeID: Int,
        isWatched: Bool
    ) {
        let request = CharacterEntity.fetchRequest()
        do {
            let characters = try context.fetch(request)
            guard let character = characters.first(where: {$0.id == characterID}),
                  let episodes = character.episodes
                    as? Set<EpisodeEntity>,
                  let episode = episodes.first(
                        where: {
                            $0.id == episodeID
                        }
                    )
            else {return}
            episode.isWatched = isWatched
            saveContext()
            fetchFavorites()
        } catch {
            print(
                error.localizedDescription
            )
        }
    }
    
    func toggleFavorite(character: Character) {
        if isFavorite(character) {
            removeFavorite(character)
        } else {
            saveFavorite(character)
        }
        fetchFavorites()
    }
    
    
    func isFavorite(_ character: Character) -> Bool {
        favorites.contains {
            $0.id == character.id
        }
    }
    
    func getCharacter(by id: Int) -> Character? {
        let request = CharacterEntity.fetchRequest()
        do {
            let characters = try context.fetch(request)
            guard let entity = characters.first(
                        where: {
                            $0.id == id
                        }
                    )
            else {return nil}
            return CharacterEntityMapper.toDomain(from: entity)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


private extension FavoritesPersistence {
    
    func saveFavorite(_ character: Character) {
        let request = CharacterEntity.fetchRequest()
        do {
            let existing = try context.fetch(request)
                .first {
                    $0.id == character.id
                }
            let favorite = existing ?? CharacterEntity(context: context)
            favorite.id = Int64(character.id)
            favorite.name = character.name
            favorite.status = character.status
            favorite.species = character.species
            favorite.gender = character.gender
            favorite.image = character.image
            favorite.originName = character.originName
            favorite.locationName = character.locationName
            favorite.isFavorite = true
            let episodeEntities = character.episodes.map { episode in
                let episodeEntity = EpisodeEntity(context: context)
                episodeEntity.id = Int64(episode.id)
                episodeEntity.name = episode.name
                episodeEntity.code = episode.code
                episodeEntity.isWatched = episode.isWatched
                return episodeEntity
            }
            
            favorite.episodes = NSSet(array: episodeEntities)
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeFavorite(_ character: Character) {
        
        if let favorite = favorites.first(where: {$0.id == character.id}) {
            favorite.isFavorite = false
            saveContext()
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}


