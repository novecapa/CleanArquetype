//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Josep Cerdá Penadés on 11/5/24.
//

import SwiftUI

@MainActor
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {

    private let imagePlaceHolder: UIImage = .placeHolder

    var url: URL?
    let urlSession: URLSessionImageProtocol
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    @State var image: UIImage?

    init(url: URL?,
         urlSession: URLSessionImageProtocol,
         @ViewBuilder content: @escaping (Image) -> ImageView,
         @ViewBuilder placeholder: @escaping () -> PlaceholderView) {
        self.url = url
        self.urlSession = urlSession
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
                    .scaledToFit()
            } else {
                placeholder()
                    .onAppear {
                        loadImage()
                    }
                    .scaledToFit()
            }
        }
    }

    private func loadImage() {
        guard let url else { return }
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest),
           let image = UIImage(data: cachedResponse.data) {
            self.image = image
        } else {
            Task {
                let (data, response) = try await urlSession.dataTask(url: urlRequest)
                if let image = UIImage(data: data) {
                    let cachedResponse = CachedURLResponse(response: response, data: data)
                    URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
