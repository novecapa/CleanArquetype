//
//  CharactersRemoteDatasource.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

protocol CardsRemoteDatasourceProtocol {
    func get(page: Int, orderBy: OrderBy) async throws -> CardsDTO
    func search(for name: String, page: Int, orderBy: OrderBy) async throws -> CardsDTO
}

enum OrderBy: String {
    case name
    case number
}

struct CardsRemoteDatasource: CardsRemoteDatasourceProtocol {

    enum Constants {
        static let cards = "cards"
        static let page = "page"
        static let pageSize = "pageSize"
        static let orderBy = "orderBy"
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

    func get(page: Int, orderBy: OrderBy = .name) async throws -> CardsDTO {
        let url = baseURL + Constants.cards
        let queryParams: [String: Any] = [
            Constants.page: page,
            Constants.pageSize: Constants.size,
            Constants.orderBy: orderBy.rawValue
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CardsDTO.self)
    }

    func search(for name: String, page: Int, orderBy: OrderBy = .name) async throws -> CardsDTO {
        let url = baseURL + Constants.cards
        let queryParams: [String: Any] = [
            Constants.page: page,
            Constants.pageSize: Constants.size,
            Constants.search: Constants.prefixName + name,
            Constants.orderBy: orderBy.rawValue
        ]
        return try await networkClient.call(urlString: url,
                                            method: .get,
                                            queryParams: queryParams,
                                            of: CardsDTO.self)
    }
}
