//
//  CharacterDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

// MARK: CharacterDTO
struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let image: String
    let location: LocationDTO
    let episode: [String]
}
extension CharacterDTO {
    var toEntity: Character {
        Character(id: id,
                  name: name,
                  status: status,
                  species: species,
                  type: type,
                  gender: gender,
                  image: image,
                  location: location.toEntity,
                  episode: episode.map { $0 })
    }
}
