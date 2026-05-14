//
//  CharacterLocation.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import CoreLocation

struct CharacterLocation:
    Identifiable {
    let id = UUID()
    let name: String
    let coordinate:
    CLLocationCoordinate2D
}
