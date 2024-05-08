//
//  CardsListBuilder.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

final class CardsListBuilder {
    func build() -> CardsListView {
        let networkClient = NetworkClient(urlSession: URLSession.shared)
        let remote = CardsRemoteDatasource(networkClient: networkClient)
        let repository = CardsRepository(remote: remote)
        let useCase = CardsUseCase(repository: repository)
        let viewModel = CardsListViewModel(useCase: useCase)
        let view = CardsListView(viewModel: viewModel)
        return view
    }
}
