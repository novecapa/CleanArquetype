//
//  CleanArquetypeApp.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import SwiftUI

@main
struct CleanArquetypeApp: App {
    var body: some Scene {
        WindowGroup {
            CardsListBuilder().build()
        }
    }
}
