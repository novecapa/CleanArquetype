//
//  CharactersListViewModel.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import SwiftUI

@Observable
final class CharactersListViewModel {

    // MARK: Public var
    var characters: [Character] = []
    var scrollToTop: Bool = false
    var showAlert: Bool = false
    var errorMessage: String = ""

    // MARK: Private var
    private var isLoading = false
    private var currentPage = 1
    private var hasNewPage = true

    private let useCase: CharactersUseCaseProtocol
    init(useCase: CharactersUseCase) {
        self.useCase = useCase
    }

    // MARK: Fetch characters paginated
    func fetchCharacters() {
        guard canLoadNewPage else { return }
        Task { @MainActor in
            do {
                isLoading = true
                let result = try await useCase.get(page: currentPage)
                populateResult(result)
                isLoading = false
            } catch {
                isLoading = false
                handleError(error)
            }
        }
    }

    private func resetPagination() {
        currentPage = 1
        hasNewPage = true
        scrollToTop = true
    }

    private var canLoadNewPage: Bool {
        hasNewPage && !isLoading
    }

    private func populateResult(_ result: Characters) {
        if currentPage == 1 {
            characters.removeAll()
            characters.append(contentsOf: result.characters)
        } else {
            characters.append(contentsOf: result.characters)
        }
        currentPage += result.addNewPage
        hasNewPage = result.hasNextPage
    }

    private func handleError(_ error: Error) {
        showAlert = true
        errorMessage = error.localizedDescription
    }
}

// MARK: Public methods
extension CharactersListViewModel {
    var firstItemId: Int {
        characters.first?.id ?? 0
    }
}
