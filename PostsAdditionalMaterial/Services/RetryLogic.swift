//
//  RetryLogic.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 06.04.2022.
//

import Foundation

extension BooksService {
    
    func retry(_ number: Int) -> BooksService {
        var composedService: BooksService = self
        for _ in 0..<number {
            composedService = BooksServiceCompositeWithFallback(mainService: composedService,
                                                                fallbackService: self)
        }
        return composedService
    }
}
