//
//  CharactersListView.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import SwiftUI

struct CharactersListView: View {

    enum Constants {
        static let columnNumber: CGFloat = 2
        static let columnSpacing: CGFloat = 4
        static let nameAndStatusHeight: CGFloat = 26
        static let backgroundColor: Color = Color.gray.opacity(0.1)
    }

    @State var viewModel: CharactersListViewModel

    var gridItems = Array(repeating: GridItem(.flexible(),
                                              spacing: Constants.columnSpacing),
                          count: Int(Constants.columnNumber))

    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationStack {
                    ScrollViewReader { scroll in
                        ScrollView {
                            LazyVGrid(columns: gridItems, spacing: Constants.columnSpacing) {
                                ForEach(viewModel.characters, id: \.id) { character in
                                    NavigationLink(destination:
                                                    CharactersDetailView()) {
                                        CharacterCell(character: character)
                                            .frame(width: geometry.size.width / Constants.columnNumber
                                                   - Constants.columnSpacing,
                                                   height: geometry.size.width / Constants.columnNumber
                                                   + Constants.nameAndStatusHeight)
                                            .onAppear {
                                                if character == viewModel.characters.last {
                                                    viewModel.fetchCharacters()
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal, Constants.columnSpacing)
                        }
                        .onChange(of: viewModel.scrollToTop) {
                            if viewModel.scrollToTop {
                                withAnimation {
                                    scroll.scrollTo(viewModel.firstItemId, anchor: .top)
                                    viewModel.scrollToTop = false
                                }
                            }
                        }
                        .navigationTitle("Rick and Morty")
                        .navigationBarTitleDisplayMode(.inline)
                        .accentColor(.black)
//                        .searchable(text: $viewModel.searchText,
//                                    placement: .navigationBarDrawer(displayMode: .always),
//                                    prompt: "Search by name".localized())
//                        .navigationBarItems(trailing: Text("\(viewModel.characters.count) \("characters".localized())")
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                        )
                        .onAppear {
                            viewModel.fetchCharacters()
                        }
                        .background(Constants.backgroundColor)
                    }
                }
                .tint(.black)
            }
        }
//        .alert(isPresented: $viewModel.showAlert) {
//            Alert(title: Text("Error".localized()),
//                  message: Text(viewModel.errorMessage),
//                  dismissButton: .default(Text("OK".localized())))
//        }
    }
}

#Preview {
    CharactersListViewPreview().build()
}
