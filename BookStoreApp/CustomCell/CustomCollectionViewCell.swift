//
//  CustomCollectionViewCell.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    //MARK: - Private Methods
    private let titleLabel = UILabel()
    private let image = UIImageView()
    private var book: Book?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(books: Book) {
        super.init(frame: .zero)
        self.book = books
    }
    
    //MARK: - Methods
    func configure(with book: Book) {
        contentView.backgroundColor = .clear
        titleLabel.text = book.title
        image.image = UIImage(named: book.image)
    }
}


//MARK: - Settings
extension CustomCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(image)
        
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 0
    }
}

//MARK: - Layout
extension CustomCollectionViewCell {
    func setupLayout() {
        image.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            image.widthAnchor.constraint(equalToConstant: 180),
            image.heightAnchor.constraint(equalToConstant: 180),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
