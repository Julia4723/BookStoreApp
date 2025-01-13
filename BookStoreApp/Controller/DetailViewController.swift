//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by user on 09.01.2025.
//


import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Property
    private let image = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    var book: Book? = nil // Передаваемая книга
    private var toggleHeart: Bool = false
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupViews()
    }
    
    
    //MARK: - Methods
    private func setupNavigationBar() {
        navigationItem.title = book?.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .red
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    @objc func favoriteButtonTapped() {
        let heart = toggleHeart ? "heart" : "heart.fill"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: heart)
        toggleHeart.toggle()
    
    }
}

//MARK: - Settings
extension DetailViewController {
   func setupViews() {
       setupImage()
       setupTileLabel()
       setupDescriptionLabel()
    }
    
    func setupImage() {
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: book?.image ?? "")
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTileLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = book?.title
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = book?.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
