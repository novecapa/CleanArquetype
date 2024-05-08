//
//  Card.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 8/5/24.
//

import Foundation

struct Card: Identifiable, Hashable {
    let id: String
    let name: String
    let image: CardImage
}
extension Card {
    var imageLargeURL: URL? {
        URL(string: image.large)
    }
    var imageSmallURL: URL? {
        URL(string: image.small)
    }
}
