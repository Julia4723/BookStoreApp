//
//  SectionBackgroundDecoration.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//


import UIKit

final class SectionBackgroundDecoration: UICollectionReusableView {
    static let reuseIdentifier = "SectionBackgroundDecoration"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension SectionBackgroundDecoration {
    func configure() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 12
    }
}
