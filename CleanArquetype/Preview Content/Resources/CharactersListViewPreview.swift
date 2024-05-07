//
//  CharactersListViewPreview.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 7/5/24.
//

import Foundation

final class CharactersListViewPreview {
    func build() -> CharactersListView {
        let remote = CharactersRemoteDatasourcePreview()
        let repository = CharactersRepository(remote: remote)
        let useCase = CharactersUseCase(repository: repository)
        let viewModel = CharactersListViewModel(useCase: useCase)
        let view = CharactersListView(viewModel: viewModel)
        return view
    }
}

extension Character {
    static let preview = Character(id: 0,
                                   name: "Rick",
                                   status: .alive,
                                   species: "Human",
                                   type: "",
                                   gender: .male,
                                   image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                   location: Location(name: "Earth", url: ""),
                                   episode: [""])
}
