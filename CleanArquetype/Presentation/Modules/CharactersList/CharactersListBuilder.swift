//
//  CharactersListBuilder.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

final class CharactersListBuilder {
    func build() -> CharactersListView {
        let networkClient = NetworkClient(urlSession: URLSession.shared)
        let remote = CharactersRemoteDatasource(networkClient: networkClient)
        let repository = CharactersRepository(remote: remote)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharactersListViewModel(useCase: useCase)
        let view = CharactersListView(viewModel: viewModel)
        return view
    }
}
