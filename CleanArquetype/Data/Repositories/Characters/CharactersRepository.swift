//
//  CharactersRepository.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

protocol CharactersRepositoryProtocol {
    func getCharacters(page: Int) async throws -> Characters
    func searchCharacters(for name: String, page: Int) async throws -> Characters
}

struct CharactersRepository: CharactersRepositoryProtocol {

    private let remote: CharactersRemoteDatasourceProtocol
    init(remote: CharactersRemoteDatasourceProtocol) {
        self.remote = remote
    }

    func getCharacters(page: Int) async throws -> Characters {
        try await remote.getCharacters(page: page).toEntity
    }

    func searchCharacters(for name: String, page: Int) async throws -> Characters {
        try await remote.searchCharacters(for: name, page: page).toEntity
    }
}
