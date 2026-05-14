//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Rick on 13/05/26.
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject private var viewModel = CharactersViewModel()
    @FocusState private var isSearchFocused: Bool
    @Binding var path: NavigationPath
    
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack(path: $path)  {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    VStack(spacing: 20) {
                        ProgressView()
                        Text("Loading characters...")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                default:
                    VStack(spacing: 16) {
                        SearchBarView(
                            text:
                                $viewModel.searchText,
                            isFocused:
                                $isSearchFocused
                        )
                        filtersSection
                        ScrollView {
                            contentView.padding(.bottom,16)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Characters")
            .task {
                await viewModel.fetchCharacters()
            }
            .refreshable {
                await viewModel.fetchCharacters()
            }
            .onTapGesture {
                isSearchFocused = false
            }
        }
    }
}


private extension CharactersView {
    var filtersSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            statusSection
            speciesSection
        }
        .padding(.top, 8)
    }
    
    var statusSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Status")
                .font(.headline)
            ScrollView( .horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    FilterChipView(title: "Alive", isSelected: viewModel.selectedStatus == "Alive") {
                        viewModel.toggleStatus("Alive")
                    }
                    FilterChipView(title: "Dead", isSelected: viewModel.selectedStatus == "Dead") {
                        viewModel.toggleStatus("Dead")
                    }
                    
                    FilterChipView(title: "unknown", isSelected: viewModel.selectedStatus == "unknown") {
                        viewModel.toggleStatus("unknown")
                    }
                }
            }
        }
    }
    
    
    var speciesSection: some View {
        VStack( alignment: .leading,spacing: 12) {
            Text("Species")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    FilterChipView(title: "Human", isSelected: viewModel.selectedSpecies == "Human") {
                        viewModel.toggleSpecies("Human")
                    }
                    FilterChipView(title: "Alien", isSelected: viewModel.selectedSpecies == "Alien") {
                        viewModel.toggleSpecies("Alien")
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.top, 100)
        case .loaded:
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.filteredCharacters) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        CharacterCardView(character: character)
                    }
                    .onAppear {
                        if character.id == viewModel.characters.last?.id {
                            Task {
                                await viewModel.fetchCharacters()
                            }
                        }
                    }
                }
                
                if viewModel.isLoadingMore {
                    ProgressView()
                        .padding()
                }
            }
            
        case .empty:
            Text("No characters found")
                .frame(maxWidth: .infinity)
                .padding(.top, 100)
            
        case .error(let message):
            Text(message)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .padding(.top, 100)
        }
    }
}
