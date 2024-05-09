//
//  NetworkError.swift
//  CleanArquetype
//
//  Created by Josep Cerdá Penadés on 6/5/24.
//

import Foundation

enum NetworkError: Error {
    /**
     200 - OK    Everything worked as expected.
     400 - Bad Request    The request was unacceptable, often due to an incorrect query string parameter
     402 - Request Failed    The parameters were valid but the request failed.
     403 - Forbidden    The user doesn't have permissions to perform the request.
     404 - Not Found    The requested resource doesn't exist.
     429 - Too Many Requests    The rate limit has been exceeded.
     500, 502, 503, 504 - Server Errors    Something went wrong on our end.
     */
    case badURL
    case clientError
    case notFound
    case badResponse
    case decodeError
    case badRequest
    case invalidResponse
}
