//
//  BooksService.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 04.04.2022.
//

import Foundation
import RealmSwift

//struct Book: Decodable {
//    let ID: UUID
//    let title: String
//    let author: String
//}

class Book: Object, Decodable {
    @Persisted var ID: UUID
    @Persisted var title: String
    @Persisted var author: String
}

class BooksService {

    var cachedList: [Book] = []
    private var networkProvider: NetworkProvider
    private let realm = try! Realm()

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
                
        let cachedBooks = realm.objects(Book.self)
        if !cachedBooks.isEmpty {
            completion(.success(cachedBooks.map { $0 }))
        } else {
            networkProvider.fetchBooks(request: .getBook, responseType: [Book].self) { result in
                switch result {
                case .success(let books):
                    try! self.realm.write {
                        self.realm.add(books)
                    }
                    completion(.success(books))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}


//class BooksService {
//
//    private var networkProvider: NetworkProvider
//
//    init(networkProvider: NetworkProvider) {
//        self.networkProvider = networkProvider
//    }
//
//    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
//        networkProvider.fetchBooks(request: .getBook, responseType: [Book].self) { result in
//            switch result {
//            case .success(let books):
//                completion(.success(books))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}

//class BooksService {
//
//    var cachedList: [Book] = []
//    private var networkProvider: NetworkProvider
//
//    init(networkProvider: NetworkProvider) {
//        self.networkProvider = networkProvider
//    }
//
//    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
//        if cachedList.isEmpty {
//            networkProvider.fetchBooks(request: .getBook, responseType: [Book].self) { result in
//                switch result {
//                case .success(let books):
//                    self.cachedList = books
//                    completion(.success(books))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        } else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                completion(.success(self.cachedList))
//            })
//        }
//    }
//}
