//
//  BooksService.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 04.04.2022.
//

import Foundation
import RealmSwift

struct Book: Object, Decodable {
    let ID: UUID
    let title: String
    let author: String
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

class BooksService {

    var cachedList: [Book] = []
    private var networkProvider: NetworkProvider

    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        if cachedList.isEmpty {
            networkProvider.fetchBooks(request: .getBook, responseType: [Book].self) { result in
                switch result {
                case .success(let books):
                    self.cachedList = books
                    completion(.success(books))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                completion(.success(self.cachedList))
            })
        }
    }
}
