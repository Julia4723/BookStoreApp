//
//  SectionHeaderView.swift
//  BookStoreApp
//
//  Created by user on 13.12.2024.
//
import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    private let label = UILabel()
    
    private var bookType: BookType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        addSubview(label)
    }
    init(bookType: BookType) {
        super.init(frame: .zero)
        self.bookType = bookType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(bookType: BookType) {
        label.text = bookType.type
    }
}
