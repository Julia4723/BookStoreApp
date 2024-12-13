//
//  BookTypeManager.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//

import UIKit

protocol IBookTypeManager {
    func getBookTypes() -> [BookType]
}

class BookTypeManager {}

extension BookTypeManager: IBookTypeManager {
    func getBookTypes() -> [BookType] {
        [
            BookType(type: "Выбор редакции", books: [
                Book(image: "book1", title: "Подводное бормотание", isNew: true),
                Book(image: "book2", title: "Один в поле воин", isNew: true),
                Book(image: "book3", title: "Мне ничего не жаль"),
                Book(image: "book4", title: "Кто ты воин?", isNew: true),
                Book(image: "book5", title: "Можно я с тобой?")
            ]),
            
            BookType(type: "Новинки в подписке", books: [
                Book(image: "book6", title: "Мы все сможем"),
                Book(image: "book7", title: "Мотивация"),
                Book(image: "book8", title: "Деградация", isNew: true),
                Book(image: "book9", title: "Параллельные прямые")
            ]),
            
            BookType(type: "Рекомендуемые", books: [
                Book(image: "book10", title: "Мы все сможем"),
                Book(image: "book11", title: "Мотивация"),
                Book(image: "book12", title: "Деградация", isNew: true),
                Book(image: "book13", title: "Параллельные прямые")
            ])
        ]
    }
}
