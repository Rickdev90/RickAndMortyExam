//
//  CharacterRepositoryImpl.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

final class CharacterRepositoryImpl: CharacterRepositoryProtocol {

    private let service: CharacterService

    init(service: CharacterService = CharacterService()) {
        self.service = service
    }

    func fetchCharacters(page: Int) async throws -> [Character] {
        let response = try await service.fetchCharacters(page: page)
        return response.results.map {
            Character(
                id: $0.id,
                name: $0.name,
                status: $0.status,
                species: $0.species,
                gender: $0.gender,
                image: $0.image,
                originName: $0.origin.name,
                locationName: $0.location.name,
                episodes: $0.episode.map { url in
                        let id = Int(url
                                .split(
                                    separator: "/"
                                )
                                .last ?? ""
                        ) ?? 0
                        return Episode(id: id, name: "", code: "")
                    }
            )
        }
    }
}
