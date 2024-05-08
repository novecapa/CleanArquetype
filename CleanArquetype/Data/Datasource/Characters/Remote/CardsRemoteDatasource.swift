//
//  CharactersRemoteDatasource.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

protocol CardsRemoteDatasourceProtocol {
    func get(page: Int) async throws -> CardsDTO
    func search(for name: String, page: Int) async throws -> CardsDTO
}

struct CardsRemoteDatasource: CardsRemoteDatasourceProtocol {

    enum Constants {
        static let cards = "cards"
        static let page = "page"
        static let pageSize = "pageSize"
        static let size = 100
        static let search = "q"
        static let prefixName = "name:"
    }

    private let baseURL: String
    private let networkClient: NetworkClientProtocol
    init(baseURL: String = Endpoints.baseURL,
         networkClient: NetworkClientProtocol) {
        self.baseURL = baseURL
        self.networkClient = networkClient
    }

    func get(page: Int) async throws -> CardsDTO {
        let url = baseURL + Constants.cards
        let queryParams = [
            Constants.page: page,
            Constants.pageSize: Constants.size
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CardsDTO.self)
    }

    func search(for name: String, page: Int) async throws -> CardsDTO {
        let url = baseURL + Constants.cards
        let queryParams: [String: Any] = [
            Constants.page: page,
            Constants.pageSize: Constants.size,
            Constants.search: Constants.prefixName + name
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CardsDTO.self)
    }
}
