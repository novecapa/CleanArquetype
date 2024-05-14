//
//  CardImageDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 8/5/24.
//

import Foundation

// MARK: - CardImageDTO
struct CardImageDTO: Codable {
    let small: String
    let large: String

    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
}
extension CardImageDTO {
    var toEntity: CardImage {
        CardImage(small: small, large: large)
    }
}
