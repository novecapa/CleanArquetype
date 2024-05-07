//
//  CharacterImagePlaceHolder.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import SwiftUI

struct CharacterImagePlaceHolder: View {
    var body: some View {
        Image(systemName: "tortoise.circle")
            .scaledToFit()
    }
}

#Preview {
    CharacterImagePlaceHolder()
}
