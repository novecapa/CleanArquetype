//
//  CharactersRemoteDatasource.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

protocol CharactersRemoteDatasourceProtocol {
    func getCharacters(page: Int) async throws -> CharactersDTO
    func searchCharacters(for name: String, page: Int) async throws -> CharactersDTO
}

struct CharactersRemoteDatasource: CharactersRemoteDatasourceProtocol {

    private let baseURL: String
    private let networkClient: NetworkClientProtocol
    init(baseURL: String = Endpoints.baseURL,
         networkClient: NetworkClientProtocol) {
        self.baseURL = baseURL
        self.networkClient = networkClient
    }

    func getCharacters(page: Int) async throws -> CharactersDTO {
        let url = baseURL + Endpoints.Constants.character
        let queryParams = [
            Endpoints.Constants.page: page
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CharactersDTO.self)
    }

    func searchCharacters(for name: String, page: Int) async throws -> CharactersDTO {
        let url = baseURL + Endpoints.Constants.character
        let queryParams: [String: Any] = [
            Endpoints.Constants.page: page,
            Endpoints.Constants.name: name
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CharactersDTO.self)
    }
}
