//
//  NetworkError.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case clientError
    case notFound
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}
