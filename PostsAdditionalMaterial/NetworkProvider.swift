//
//  NetworkProvider.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation

enum Request {
    case getBook
    case getAuthors
}

class NetworkProvider {
    
    func fetchBooks<T: Decodable>(request: Request,
                                  responseType: T.Type,
                                  completion: @escaping (Result<T, Error>) -> Void) {
        
        switch request {
        case .getBook:
            guard let path = Bundle.main.path(forResource: "books", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
                  let booksList = try? JSONDecoder().decode([Book].self, from: data) else {
                      completion(.failure(NSError.simpleError("Remote service issue!")))
                      return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                completion(.success(booksList as! T))
            })
        default: ()
        }
    }
}
