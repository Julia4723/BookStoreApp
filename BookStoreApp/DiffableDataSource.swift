//
//  DiffableDataSource.swift
//  BookStoreApp
//
//  Created by user on 06.01.2025.
//

import UIKit

class DiffableDataSource<Section: Equatable, Item>: NSObject, UICollectionViewDataSource {
    
    typealias CellProvider = (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
    
    private var cellProvider: CellProvider
    private var sections: [Section] = []
    private var dictionary: [Int: [Item]] = [:]
    
    init(collectionView: UICollectionView, cellProvider: @escaping CellProvider) {
        self.cellProvider = cellProvider
        super.init()
        collectionView.dataSource = self
    }
    
    func appendSection(_ sections: [Section]) {
        self.sections = sections
    }
    
    func appendItems(_ items: [Item], section: Section) {
        if let index = sections.firstIndex(of: section) { //определяем индекс секции
            dictionary[index] = items // Добавляем массив items в словарь по индексу секции в массиве sections
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dictionary[section]?.count ?? 0 // массив по ключу section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let items = dictionary[indexPath.section]
        let item = items![indexPath.row]
        
        guard let cell = cellProvider(collectionView, indexPath, item) else { return UICollectionViewCell()}
        return cell
    }
    
}
