//
//  CharacterResponseDTO.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

struct CharacterResponseDTO: Codable {
    let info: InfoDTO
    let results: [CharacterDTO]
}
