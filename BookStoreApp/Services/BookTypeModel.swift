//
//  Model.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//

import UIKit

struct BookType: Hashable {
    let type: String
    let books: [Book]
}

struct Book: Hashable {
    let image: String
    let title: String
    let description: String
    var isNew = false
}
