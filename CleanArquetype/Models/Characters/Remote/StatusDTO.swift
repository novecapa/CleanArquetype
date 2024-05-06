//
//  StatusDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

// MARK: StatusDTO
enum StatusDTO: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
