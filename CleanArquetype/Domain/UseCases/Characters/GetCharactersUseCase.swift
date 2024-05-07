//
//  GetUseCase.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import Foundation

protocol CharactersUseCaseProtocol {
    func get(page: Int) async throws -> Characters
    func search(for name: String, page: Int) async throws -> Characters
}

struct CharactersUseCase: CharactersUseCaseProtocol {

    let repository: CharactersRepositoryProtocol
    init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }

    func get(page: Int) async throws -> Characters {
        try await repository.getCharacters(page: page)
    }

    func search(for name: String, page: Int) async throws -> Characters {
        try await repository.searchCharacters(for: name, page: page)
    }
}
