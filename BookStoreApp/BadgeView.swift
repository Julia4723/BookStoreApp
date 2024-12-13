//
//  BadgeView.swift
//  BookStoreApp
//
//  Created by user on 13.12.2024.
//

import UIKit

final class BadgeView: UICollectionReusableView {
    static let reuseIdentifier = "BadgeView"
    private var badgeLabel = UILabel()
    private var book: Book?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    init(books: Book) {
        super.init(frame: .zero)
        self.book = books
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureBadge(with badge: String) {
        isHidden = false
        badgeLabel.text = "New"
    }
}


private extension BadgeView {
    func setupView() {
        badgeLabel.frame = bounds
        badgeLabel.backgroundColor = .purple
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 4
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
        
    }
}
