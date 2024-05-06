//
//  InfoDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

// MARK: InfoDTO
struct InfoDTO: Codable, Hashable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
