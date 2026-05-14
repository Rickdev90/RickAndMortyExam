//
//  CharacterEntityMapper.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import CoreData

struct CharacterEntityMapper {
    
    static func toEntity(from character: Character, context: NSManagedObjectContext) -> CharacterEntity {
        let entity = CharacterEntity(context: context)
        entity.id = Int64(character.id)
        entity.name = character.name
        entity.status = character.status
        entity.species = character.species
        entity.gender = character.gender
        entity.image = character.image
        entity.originName = character.originName
        entity.locationName = character.locationName
        let episodeEntities = character.episodes.map { episode in
            let episodeEntity = EpisodeEntity(context: context)
            episodeEntity.id = Int64(episode.id)
            episodeEntity.name = episode.name
            episodeEntity.code = episode.code
            episodeEntity.isWatched = episode.isWatched
            return episodeEntity
        }
        
        entity.episodes = NSSet(array: episodeEntities)
        return entity
    }
    
    static func toDomain( from entity: CharacterEntity ) -> Character {
        let episodes = (entity.episodes as? Set<EpisodeEntity>)?
            .map {
                Episode(
                    id: Int($0.id),
                    name: $0.name ?? "",
                    code: $0.code ?? "",
                    isWatched: $0.isWatched
                )
            }
        ?? []
        
        return Character(
            id: Int(entity.id),
            name: entity.name ?? "",
            status: entity.status ?? "",
            species: entity.species ?? "",
            gender: entity.gender ?? "",
            image: entity.image ?? "",
            originName: entity.originName ?? "",
            locationName: entity.locationName ?? "",
            episodes: episodes
        )
    }
}
