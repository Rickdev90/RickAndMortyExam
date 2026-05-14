//
//  EpisodeService.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

final class EpisodeService {

    func fetchEpisode(from urlString: String) async throws -> EpisodeDTO {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(
            EpisodeDTO.self,
            from: data
        )
    }
}
