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
                .frame(width: 100, height: 120)
            }
        }
        .onAppear {
            viewModel.fetchCards()
        }
        .overlay(
            Group {
                if isZoomed {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .zIndex(1)
                        .onTapGesture {
                            withAnimation {
                                isZoomed.toggle()
                                selectedCard = nil
                            }
                        }
                    if let selectedCard {
                        ZoomedView(selectedCard: selectedCard, isZoomed: $isZoomed)
                            .transition(.scale)
                            .zIndex(2)
                    }
                }
            }
        )
    }
}

struct ZoomedView: View {
    let selectedCard: Card
    @Binding var isZoomed: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CardCell(card: selectedCard)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
                    .cornerRadius(8)
                    .onTapGesture {
                        withAnimation {
                            isZoomed.toggle()
                        }
                    }
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .transition(.asymmetric(insertion: .scale, removal: .scale))
        }
    }
}

#Preview {
    CardsListViewPreview().build()
}
