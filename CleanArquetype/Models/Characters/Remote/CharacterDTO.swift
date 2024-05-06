//
//  CharacterDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

// MARK: CharacterDTO
struct CharacterDTO: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: StatusDTO
    let species: SpeciesDTO
    let type: String
    let gender: GenderDTO
    let image: String
    let location: LocationDTO
    let episode: [String]
}
