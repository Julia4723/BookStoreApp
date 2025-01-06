//
//  Model.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//

import UIKit

struct BookType {
    let type: String
    let books: [Book]
}

struct Book: Hashable {
    let image: String
    let title: String
    var isNew = false
}
