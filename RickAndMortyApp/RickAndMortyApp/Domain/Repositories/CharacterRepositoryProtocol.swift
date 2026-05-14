//
//  CharacterRepositoryProtocol.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func fetchCharacters(page: Int) async throws -> [Character]
}
