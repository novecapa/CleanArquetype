//
//  CardsListViewModel.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import SwiftUI

final class CardsListViewModel: ObservableObject {

    // MARK: Public var
    @Published var cards: [Card] = []
    @Published var searchText: String = "" {
        didSet {
            if searchText.count > 1 {
                resetPagination()
                searchCards()
            } else if searchText.isEmpty {
                resetPagination()
                fetchCards()
            }
        }
    }
    @Published var scrollToTop: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var canLoadNewPage = true

    // MARK: Private var
    private var currentPage = 1

    private let useCase: CardsUseCaseProtocol
    init(useCase: CardsUseCase) {
        self.useCase = useCase
    }

    private func searchCards() {
        guard canLoadNewPage else { return }
        Task { @MainActor in
            do {
                canLoadNewPage = false
                let result = try await useCase.search(for: searchText, page: currentPage)
                populateResult(result)
            } catch {
                canLoadNewPage = true
                handleError(error)
            }
        }
    }

    private func resetPagination() {
        currentPage = 1
        canLoadNewPage = true
        scrollToTop = true
    }

    private func populateResult(_ result: Cards) {
        if currentPage == 1 {
            cards.removeAll()
            cards.append(contentsOf: result.data)
        } else {
            cards.append(contentsOf: result.data)
        }
        currentPage += 1
        canLoadNewPage = result.hasNewPage
    }

    private func handleError(_ error: Error) {
        showAlert = true
        errorMessage = error.localizedDescription
    }
}

// MARK: Public methods
extension CardsListViewModel {
    func fetchCards() {
        guard canLoadNewPage else { return }
        Task { @MainActor in
            do {
                canLoadNewPage = false
                let result = try await useCase.get(page: currentPage)
                populateResult(result)
            } catch {
                canLoadNewPage = true
                handleError(error)
            }
        }
    }

    var firstItemId: String {
        cards.first?.id ?? ""
    }
}
