//
//  CardsDTO.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 8/5/24.
//

import Foundation

// MARK: - CardsDTO
struct CardsDTO: Codable {
    let data: [CardDTO]
    let page: Int
    let pageSize: Int
    let count: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case data
        case page
        case pageSize
        case count
        case totalCount
    }
}
extension CardsDTO {
    var toEntity: Cards {
        Cards(data: data.map { $0.toEntity },
              page: page,
              pageSize: pageSize,
              count: count,
              totalCount: totalCount)
    }
}
