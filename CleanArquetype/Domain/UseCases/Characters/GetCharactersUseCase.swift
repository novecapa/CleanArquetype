//
//  GetUseCase.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import Foundation

protocol CardsUseCaseProtocol {
    func get(page: Int) async throws -> Cards
    func search(for name: String, page: Int) async throws -> Cards
}

struct CardsUseCase: CardsUseCaseProtocol {

    let repository: CardsRepositoryProtocol
    init(repository: CardsRepositoryProtocol) {
        self.repository = repository
    }

    func get(page: Int) async throws -> Cards {
        try await repository.get(page: page)
    }

    func search(for name: String, page: Int) async throws -> Cards {
        try await repository.search(for: name, page: page)
    }
}
