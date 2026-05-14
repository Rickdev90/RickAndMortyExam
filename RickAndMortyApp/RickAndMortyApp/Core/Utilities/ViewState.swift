//
//  ViewState.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}
