//
//  CharactersViewModelTests.swift
//  RickAndMortyAppTests
//
//  Created by Rick on 14/05/26.
//

import XCTest
@testable import RickAndMortyApp

@MainActor final class CharactersViewModelTests: XCTestCase {

    func testFetchCharactersSuccess() async {
        let repository = MockCharacterRepository()
        let viewModel = CharactersViewModel(repository: repository)
        await viewModel.fetchCharacters()
        XCTAssertEqual( viewModel.characters.count,1)
        XCTAssertEqual( viewModel.state, .loaded)
    }

    func testFetchCharactersFailure() async {
        let repository = MockCharacterRepository()
        repository.shouldFail = true
        let viewModel = CharactersViewModel(repository: repository)
        await viewModel
            .fetchCharacters()
        XCTAssertFalse(viewModel.state == .loading)
    }
}
