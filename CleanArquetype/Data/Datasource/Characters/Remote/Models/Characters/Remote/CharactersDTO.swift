//
//  CharactersDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

// MARK: CharactersDTO
struct CharactersDTO: Codable {
    let info: InfoDTO
    let results: [CharacterDTO]
}

extension CharactersDTO {
    var toEntity: Characters {
        Characters(characters: results.map { $0.toEntity },
                   hasNextPage: info.hasNextPage)
    }
}
