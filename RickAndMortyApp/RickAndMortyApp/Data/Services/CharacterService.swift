//
//  CharacterService.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

final class CharacterService {
    
    func fetchCharacters(page: Int) async throws -> CharacterResponseDTO {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(page)"
        ) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared
            .data(from: url)
        let response = try JSONDecoder().decode(
            CharacterResponseDTO.self,
            from: data
        )
        return response
    }
}
