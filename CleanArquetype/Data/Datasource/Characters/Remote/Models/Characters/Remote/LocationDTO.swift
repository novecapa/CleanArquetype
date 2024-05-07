//
//  LocationDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

// MARK: LocationDTO
struct LocationDTO: Codable {
    let name: String
    let url: String
}
extension LocationDTO {
    var toEntity: Location {
        Location(name: name, url: url)
    }
}
