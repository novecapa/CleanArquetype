//
//  CardsRemoteDatasourcePreview.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import Foundation

struct CardsRemoteDatasourcePreview: CardsRemoteDatasourceProtocol {

    private enum Constants {
        static let fileName: String = "CardsDTO"
        static let jsonExt: String = "json"
    }
    
    private let fileName: String
    init(fileName: String = Constants.fileName) {
        self.fileName = fileName
    }

    private var bundleURL: URL {
        Bundle.main.url(forResource: fileName, withExtension: Constants.jsonExt)!
    }

    func get(page: Int, orderBy: OrderBy) async throws -> CardsDTO {
        let data = try Data(contentsOf: bundleURL)
        return try JSONDecoder().decode(CardsDTO.self, from: data)
    }

    func search(for name: String, page: Int, orderBy: OrderBy) async throws -> CardsDTO {
        let data = try Data(contentsOf: bundleURL)
        let cards = try JSONDecoder().decode(CardsDTO.self, from: data).data.filter {
            $0.name.lowercased().contains(name.lowercased())
        }
        return CardsDTO(data: cards, page: 1, pageSize: 1, count: 1, totalCount: 1)
    }
}
