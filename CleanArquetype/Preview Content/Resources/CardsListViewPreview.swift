//
//  CardsListViewPreview.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import Foundation

final class CardsListViewPreview {
    func build() -> CardsListView {
        let remote = CardsRemoteDatasourcePreview()
        let repository = CardsRepository(remote: remote)
        let useCase = CardsUseCase(repository: repository)
        let viewModel = CardsListViewModel(useCase: useCase)
        let view = CardsListView(viewModel: viewModel)
        return view
    }
}

extension Card {
    static let cardPreview = Card(id: "1",
                                  name: "Name",
                                  image: CardImage(small: "",
                                                   large: "https://images.pokemontcg.io/xy2/3_hires.png"))
}
