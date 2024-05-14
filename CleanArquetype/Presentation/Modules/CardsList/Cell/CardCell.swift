//
//  CardCell.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import SwiftUI

struct CardCell: View {

    enum Constants {
        static let circleDiam: CGFloat = 20
        static let fontSize: CGFloat = 14
        static let paddingSize: CGFloat = 6
        static let defaultSize: CGFloat = 120
    }

    let card: Card
    let frameSize: CGFloat
    let urlSessionImage: URLSessionImageProtocol
    init(_ card: Card,
         frameSize: CGFloat = Constants.defaultSize,
         urlSessionImage: URLSessionImageProtocol = URLSession.shared) {
        self.card = card
        self.frameSize = frameSize
        self.urlSessionImage = urlSessionImage
    }

    var body: some View {
        VStack(alignment: .center) {
            AsyncCachedImage(url: card.imageLargeURL,
                             urlSession: urlSessionImage) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .transition(.opacity.animation(.default))
            } placeholder: {
                ProgressView()
                    .scaledToFit()
                    .frame(width: frameSize, height: frameSize)
                    .background(.black)
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
    CardCell(.cardPreview)
}
