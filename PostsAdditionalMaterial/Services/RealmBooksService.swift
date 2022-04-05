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

class RealmBooksService: BooksService {
    
    private let realm = try! Realm()
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        let cachedBooks = realm.objects(RealmBook.self)
        completion(.success(cachedBooks.map { Book(ID: $0.ID, title: $0.title, author: $0.author) }))
    }
}
