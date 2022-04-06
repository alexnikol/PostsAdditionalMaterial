//
//  CompositeLocalServiceWithRemoteFallback.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation
import RealmSwift

class CompositeLocalServiceWithRemoteFallback: BooksService {

    private let mainService: BooksService
    private let fallbackService: BooksService
    
    init(mainService: BooksService, fallbackService: BooksService) {
        self.mainService = mainService
        self.fallbackService = fallbackService
    }
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        mainService.loadList { [weak self] result in
            guard let self = self else { return }
            if let books = try? result.get(), !books.isEmpty {
                completion(.success(books))
            } else {
                self.fallbackService.loadList { remoteResult in
                    switch remoteResult {
                    case .success(let books):
                        completion(.success(books))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

extension RealmBook {
    convenience init(book: Book) {
        self.init()
        self.ID = book.ID
        self.title = book.title
        self.author = book.author
    }
}
