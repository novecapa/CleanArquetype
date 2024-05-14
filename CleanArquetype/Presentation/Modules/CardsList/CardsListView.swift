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
        static let cornerRadius: CGFloat = 8
        // `nameHeight` is not a magic number, is the size
        // to expand height like a card height + text title
        static let nameHeight: CGFloat = 100
        static let frameLoading: CGFloat = 120
        static let backgroundColor: Color = Color.gray.opacity(0.1)
        static let overlayBackColor: Color = Color.black.opacity(0.8)
    }

    @State private var isZoomed = false
    @State private var selectedCard: Card? = nil
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
                                ForEach(viewModel.cards, id: \.id) { card in
                                    CardCell(card,
                                             frameSize: frameSize - Constants.columnSpacing)
                                    .padding(.horizontal, Constants.columnSpacing)
                                    .frame(width: frameSize - Constants.columnSpacing,
                                           height: frameSize + Constants.nameHeight)
                                    .onAppear {
                                        if card == viewModel.cards.last {
                                            viewModel.fetchCards()
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            isZoomed.toggle()
                                            selectedCard = card
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
                .frame(width: Constants.frameLoading,
                       height: Constants.frameLoading)
                .background(.black)
                .cornerRadius(Constants.cornerRadius)
            }
        }
        .onAppear {
            viewModel.fetchCards()
        }
        .overlay(
            Group {
                if isZoomed,
                   let card = selectedCard {
                    Constants.overlayBackColor
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                isZoomed.toggle()
                                selectedCard = nil
                            }
                        }
                    CardCell(card)
                        .onTapGesture {
                            withAnimation {
                                isZoomed.toggle()
                                selectedCard = nil
                            }
                        }
                        .transition(.scale)
                        .cornerRadius(Constants.cornerRadius)
                        .padding()
                }
            }
        )
    }
}

#Preview {
    CardsListViewPreview().build()
}
