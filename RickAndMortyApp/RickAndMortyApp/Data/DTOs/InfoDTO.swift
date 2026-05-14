//
//  CharacterDTO.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

struct InfoDTO: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
