//
//  CharacterMapView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI
import MapKit

struct CharacterMapView: View {
    let characterName: String
    let coordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion
    
    init(characterName: String, coordinate: CLLocationCoordinate2D) {
        self.characterName = characterName
        self.coordinate = coordinate
        _region = State(
            initialValue:
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.5,
                        longitudeDelta: 0.5
                    )
                )
        )
    }
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [CharacterLocation(name: characterName, coordinate: coordinate)]
        ) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack(spacing: 6) {
                    Image(systemName:"mappin.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    Text(location.name)
                        .font(.caption)
                        .padding(8)
                        .background(.white)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 10
                            )
                        )
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Map")
    }
}
