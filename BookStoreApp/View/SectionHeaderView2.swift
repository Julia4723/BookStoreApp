//
//  SectionHeaderView2.swift
//  BookStoreApp
//
//  Created by user on 19.12.2024.
//

import UIKit

class SectionHeaderView2: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView2"
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(label)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }
}

extension SectionHeaderView2 {
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
