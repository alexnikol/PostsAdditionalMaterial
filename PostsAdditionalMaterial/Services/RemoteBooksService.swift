//
//  RemoteBooksService.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation

struct RemoteBook: Decodable {
    let ID: UUID
    let title: String
    let author: String
}

class RemoteBooksService: BooksService {
    
    private var networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func loadList(completion: @escaping (Result<[Book], Error>) -> Void) {
        networkProvider.fetchBooks(request: .getBook, responseType: [RemoteBook].self) { result in
            switch result {
            case .success(let remoteBooks):
                let booksModels = remoteBooks.map { Book(ID: $0.ID, title: $0.title, author: $0.author) }
                completion(.success(booksModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
