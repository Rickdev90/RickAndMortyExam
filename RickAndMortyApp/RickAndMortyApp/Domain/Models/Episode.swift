//
//  Models.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

struct Episode: Identifiable {

    let id: Int
    let name: String
    let code: String
    var isWatched: Bool = false
}
