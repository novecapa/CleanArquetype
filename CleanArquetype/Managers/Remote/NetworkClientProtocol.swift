//
//  NetworkClientProtocol.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

protocol NetworkClientProtocol {
    func call<T: Decodable>(urlString: String,
                            method: NetworkMethod,
                            queryParams: [String: Any]?,
                            of type: T.Type) async throws -> T
}
