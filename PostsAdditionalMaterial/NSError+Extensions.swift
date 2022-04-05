//
//  NSError+Extensions.swift
//  PostsAdditionalMaterial
//
//  Created by Alexander Nikolaychuk on 05.04.2022.
//

import Foundation

extension NSError {
    static func simpleError(_ message: String) -> NSError {
        return NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
