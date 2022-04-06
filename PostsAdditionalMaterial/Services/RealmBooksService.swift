//
//  RealmBooksService.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation
import RealmSwift

class RealmBook: Object {
    @Persisted var ID: UUID
    @Persisted var title: String
    @Persisted var author: String
}

protocol BooksCache {
    func save(books: [Book])
}

class RealmBooksService: BooksService, BooksCache {
    
    private let realm = try! Realm()
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            print("REALM_SERVICE_LOADED")
            let cachedBooks = self.realm.objects(RealmBook.self)
            completion(.success(cachedBooks.map { Book(ID: $0.ID, title: $0.title, author: $0.author) }))
        })
    }
    
    func save(books: [Book]) {
        try! self.realm.write {
            self.realm.add(books.map { RealmBook(book: $0) })
        }
    }
}
