//
//  CardCell.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import SwiftUI

struct CardCell: View {

    let card: Card
    var body: some View {
        VStack(alignment: .center) {
            if let url = card.imageLargeURL {
                AsyncImage(
                    url: url,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                    },
                    placeholder: {
                        CardImagePlaceHolder()
                    }
                )
            } else {
                CardImagePlaceHolder()
            }
            VStack {
                Text(card.name)
                    .foregroundStyle(.black)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 32)
                    .background(.yellow)
                    .font(.title)
                    .cornerRadius(4.0)
            }
            .padding(.horizontal, 8)
        }
    }
    
}

#Preview {
    CardCell(card: .cardPreview)
}
