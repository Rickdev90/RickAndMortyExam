//
//  MockCharacterRepository.swift
//  RickAndMortyAppTests
//
//  Created by Rick on 14/05/26.
//

import Foundation
@testable import RickAndMortyApp

final class MockCharacterRepository: CharacterRepositoryProtocol {

    var shouldFail = false
    func fetchCharacters(page: Int) async throws -> [Character] {

        if shouldFail {
            throw URLError(.badServerResponse)
        }

        return [Character(
                id: 1,
                name: "Rick",
                status: "Alive",
                species: "Human",
                gender: "Male",
                image: "",
                originName: "Earth",
                locationName: "Citadel",
                episodes: []
            )]
    }
}
