//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

struct Character: Identifiable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let originName: String
    let locationName: String
    var episodes: [Episode]
}
