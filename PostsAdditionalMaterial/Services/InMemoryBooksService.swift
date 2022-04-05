//
//  InMemoryBooksService.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation

class InMemoryBooksService: BooksService {
    
    var cachedList: [Book] = []
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        completion(.success(cachedList))
    }
}
