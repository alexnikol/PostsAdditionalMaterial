//
//  InMemoryBooksService.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation

class InMemoryBooksService: BooksService, BooksCache {
    
    var cachedList: [Book] = []
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        if cachedList.isEmpty {
            completion(.failure(NSError.simpleError("Cache is empty!")))
        } else {
            completion(.success(cachedList))
        }
    }
    
    func save(books: [Book]) {
        cachedList = books
    }
}
