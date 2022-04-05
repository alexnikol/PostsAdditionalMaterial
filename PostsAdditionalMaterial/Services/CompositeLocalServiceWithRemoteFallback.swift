//
//  CompositeLocalServiceWithRemoteFallback.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation
import RealmSwift

extension RealmBook {
    convenience init(book: Book) {
        self.init()
        self.ID = book.ID
        self.title = book.title
        self.author = book.author
    }
}

class CompositeLocalServiceWithRemoteFallback: BooksService {
    
    private let realm = try! Realm()
    private let localService: RealmBooksService
    private let remoteService: RemoteBooksService
    
    init(localService: RealmBooksService, remoteService: RemoteBooksService) {
        self.localService = localService
        self.remoteService = remoteService
    }
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        localService.loadList { [weak self] result in
            guard let self = self else { return }
            if let books = try? result.get(), !books.isEmpty {
                completion(.success(books))
            } else {
                self.remoteService.loadList { remoteResult in
                    switch remoteResult {
                    case .success(let books):
                        
                        // SAVE TO REALM CACHE
                        let realmBooks = books.map { RealmBook(book: $0) }
                        try! self.realm.write {
                            self.realm.add(realmBooks)
                        }
                        
                        completion(.success(books))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

//
//class RemoteBooksServiceRealmCacheDecorator: BooksService {
//
//    private let realm = try! Realm()
//    private let remoteLoader: RemoteBooksService
//
//    init(remoteLoader: RemoteBooksService) {
//        self.remoteLoader = remoteLoader
//    }
//
//    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
//        let cachedBooks = realm.objects(RealmBook.self)
//        completion(.success(cachedBooks.map { Book(ID: $0.ID, title: $0.title, author: $0.author) }))
//    }
//}
