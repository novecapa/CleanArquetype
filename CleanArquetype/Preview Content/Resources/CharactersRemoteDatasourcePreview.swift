//
//  CharactersRemoteDatasourcePreview.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import Foundation

struct CharactersRemoteDatasourcePreview: CharactersRemoteDatasourceProtocol {

    private enum Constants {
        static let fileName: String = "CharactersDTO"
        static let jsonExt: String = "json"
    }
    
    private let fileName: String
    init(fileName: String = Constants.fileName) {
        self.fileName = fileName
    }

    private var bundleURL: URL {
        Bundle.main.url(forResource: fileName, withExtension: Constants.jsonExt)!
    }

    func getCharacters(page: Int) async throws -> CharactersDTO {
        let data = try Data(contentsOf: bundleURL)
        return try JSONDecoder().decode(CharactersDTO.self, from: data)
    }
    
    func searchCharacters(for name: String, page: Int) async throws -> CharactersDTO {
        let data = try Data(contentsOf: bundleURL)
        return try JSONDecoder().decode(CharactersDTO.self, from: data)
    }
}
