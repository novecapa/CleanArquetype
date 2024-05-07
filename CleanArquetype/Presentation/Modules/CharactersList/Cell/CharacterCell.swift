//
//  CharacterCell.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import SwiftUI

struct CharacterCell: View {

    let character: Character
    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: character.image) {
                AsyncImage(
                    url: url,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                    },
                    placeholder: {
                        CharacterImagePlaceHolder()
                    }
                )
            } else {
                CharacterImagePlaceHolder()
            }
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text(character.status.rawValue)
                    .font(.callout)
                    .foregroundStyle(character.status == .alive ? .green : .red)
                Text(character.species)
                    .font(.footnote)
            }
        }
    }
    
}

#Preview {
    CharacterCell(character: .preview)
}
