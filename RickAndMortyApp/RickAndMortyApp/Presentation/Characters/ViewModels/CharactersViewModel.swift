//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import Foundation
import Combine
import CoreData

@MainActor
final class CharactersViewModel:
    ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var state: ViewState = .idle
    @Published var searchText: String = ""
    @Published var selectedStatus: String? = nil
    @Published var selectedSpecies: String? = nil
    @Published var isLoadingMore = false
    private var currentPage = 1
    private var canLoadMore = true
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol = CharacterRepositoryImpl()) {
        self.repository = repository
    }
    
    var filteredCharacters: [Character] {
        characters.filter { character in
            let matchesSearch = searchText.isEmpty || character.name
                .localizedCaseInsensitiveContains(searchText)
            let matchesStatus = selectedStatus == nil || character.status == selectedStatus
            let matchesSpecies = selectedSpecies == nil || character.species == selectedSpecies
            return matchesSearch && matchesStatus && matchesSpecies
        }
    }
    
    func fetchCharacters() async {
        guard !isLoadingMore, canLoadMore
        else { return }
        if currentPage == 1 {
            state = .loading
        }
        isLoadingMore = true
        do {
            let response = try await repository.fetchCharacters(page: currentPage)
            characters.append(contentsOf: response)
            saveCharactersToCoreData(response)
            currentPage += 1
            canLoadMore = !response.isEmpty
            state = .loaded
        } catch {
            if currentPage == 1 {
                loadCharactersFromCoreData()
            }
        }
        isLoadingMore = false
    }
    
    private func saveCharactersToCoreData(_ characters: [Character]) {
        
        let context = PersistenceController.shared.container.viewContext
        do {
            for character in characters {
                let request = CharacterEntity.fetchRequest()
                let existing = try context.fetch(request)
                    .first {
                        $0.id == character.id
                    }
                if existing == nil {
                    _ = CharacterEntityMapper.toEntity(
                            from: character,
                            context: context
                        )
                }
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadCharactersFromCoreData() {
        
        let context = PersistenceController.shared.container.viewContext
        let request = CharacterEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            let characters = entities.map {
                CharacterEntityMapper
                    .toDomain(from: $0)
            }
            self.characters = characters
            state = characters.isEmpty ? .empty : .loaded
        } catch {
            state = .error(
                error.localizedDescription
            )
        }
    }
    
    func toggleStatus(_ status: String) {
        if selectedStatus == status {
            selectedStatus = nil
        } else {
            selectedStatus = status
        }
    }
    
    
    func toggleSpecies(_ species: String) {
        if selectedSpecies == species {
            selectedSpecies = nil
        } else {
            selectedSpecies = species
        }
    }
}
