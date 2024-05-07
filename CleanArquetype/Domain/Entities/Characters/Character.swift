//
//  Character.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation
import SwiftUI

struct Character: Identifiable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let image: String
    let location: Location
    let episode: [String]
}
