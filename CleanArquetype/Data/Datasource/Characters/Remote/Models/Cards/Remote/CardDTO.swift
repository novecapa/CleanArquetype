//
//  CardDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 8/5/24.
//

import Foundation

// MARK: - CardDTO
struct CardDTO: Codable {
    let id: String
    let name: String
    let images: CardImageDTO

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case images
    }
}
extension CardDTO {
    var toEntity: Card {
        Card(id: id, name: name, image: images.toEntity)
    }
}
