//
//  Cards.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 8/5/24.
//

import Foundation

struct Cards: Hashable {
    let data: [Card]
    let page: Int
    let pageSize: Int
    let count: Int
    let totalCount: Int
}
extension Cards {
    var hasNewPage: Bool {
        count == pageSize
    }
}
