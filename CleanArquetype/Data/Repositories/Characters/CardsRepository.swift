//
//  CharactersRepository.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

protocol CardsRepositoryProtocol {
    func get(page: Int) async throws -> Cards
    func search(for name: String, page: Int) async throws -> Cards
}

struct CardsRepository: CardsRepositoryProtocol {

    private let remote: CardsRemoteDatasourceProtocol
    init(remote: CardsRemoteDatasourceProtocol) {
        self.remote = remote
    }

    func get(page: Int) async throws -> Cards {
        try await remote.get(page: page, orderBy: .name).toEntity
    }

    func search(for name: String, page: Int) async throws -> Cards {
        try await remote.search(for: name, page: page, orderBy: .name).toEntity
    }
}
