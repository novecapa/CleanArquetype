//
//  CardsListView.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import SwiftUI

struct CardsListView: View {

    enum Constants {
        static let columnNumber: CGFloat = 2
        static let columnSpacing: CGFloat = 4
        static let nameHeight: CGFloat = 100
        static let backgroundColor: Color = Color.gray.opacity(0.1)
    }

    @StateObject var viewModel: CardsListViewModel

    var gridItems = Array(repeating: GridItem(.flexible(),
                                              spacing: Constants.columnSpacing),
                          count: Int(Constants.columnNumber))
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let frameSize = geometry.size.width / Constants.columnNumber
                NavigationStack {
                    ScrollViewReader { scroll in
                        ScrollView {
                            LazyVGrid(columns: gridItems,
                                      spacing: Constants.columnSpacing) {
                                ForEach(viewModel.cards, id: \.self) { card in
                                    CardCell(card: card)
                                        .frame(width: frameSize,
                                               height: frameSize + Constants.nameHeight)
                                        .padding(.horizontal, Constants.columnSpacing)
                                        .onAppear {
                                            if card == viewModel.cards.last {
                                                viewModel.fetchCards()
                                            }
                                        }
                                }
                            }
                        }
                        .onChange(of: viewModel.scrollToTop, perform: { value in
                            if viewModel.scrollToTop {
                                withAnimation {
                                    scroll.scrollTo(viewModel.firstItemId,
                                                    anchor: .top)
                                    viewModel.scrollToTop = false
                                }
                            }
                        })
                    }
                    .navigationTitle("Pokémon")
                    .searchable(text: $viewModel.searchText,
                                placement: .navigationBarDrawer(displayMode: .always),
                                prompt: "Search by name")
                    .navigationBarItems(trailing: Text("\(viewModel.cards.count)")
                        .font(.footnote)
                        .foregroundColor(.gray))
                }
            }
            .padding(.horizontal, Constants.columnSpacing)
            if !viewModel.canLoadNewPage {
                VStack {
                    ProgressView()
                        .tint(.yellow)
                    Text("Loading...")
                        .padding(.top)
                }
                .frame(width: 100, height: 120)
            }
        }
        .onAppear {
            viewModel.fetchCards()
        }
    }
}

#Preview {
    CardsListViewPreview().build()
}
