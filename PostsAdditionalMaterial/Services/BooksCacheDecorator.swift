//
//  BooksCacheDecorator.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation
import RealmSwift

class BooksCacheDecorator: BooksService {

    private let loadService: BooksService
    private let cacheService: BooksCache

    init(loadService: BooksService, cacheService: BooksCache) {
        self.loadService = loadService
        self.cacheService = cacheService
    }

    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        loadService.loadList { [weak self] result in
            switch result {
            case .success(let books):
                self?.cacheService.save(books: books)
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
