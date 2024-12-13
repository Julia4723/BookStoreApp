//
//  ViewController.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//

import UIKit

struct ElementKind {
    static let background = "section-background-element-kind"
    static let badge = "badge-element-kind"
}


final class ViewController: UIViewController {
    
    //MARK: - Private Methods
    private let reuseIdentifier = "reuseIdentifierCell"
    private var collectionView: UICollectionView!
    
    var bookManager: IBookTypeManager?
    private var booksArray: [BookType] = []
    
    //MARK: - Init
    init(bookManager: IBookTypeManager) {
        self.bookManager = bookManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionView()
        getBooks()
    }
    
    //MARK: - Methods
    func getBooks() {
        guard let manager = bookManager else { return }
        booksArray = manager.getBookTypes()
        collectionView.reloadData()
    }
    
}

//MARK: - SetupView
private extension ViewController {
    func setupView() {
        let layout = createLayout()
       
        layout.register(SectionBackgroundDecoration.self, forDecorationViewOfKind: ElementKind.background)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
        
        collectionView.register(BadgeView.self, forSupplementaryViewOfKind: ElementKind.badge, withReuseIdentifier: BadgeView.reuseIdentifier)
        
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
}

//MARK: - Create Layout
private extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        
        let supplementaryItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(70),
            heightDimension: .absolute(22)
        )
        
        let constraints = NSCollectionLayoutAnchor(
            edges: [.top, .leading],
            absoluteOffset: CGPoint(x: 0, y: -22)
        )
        
        let supplementaryItem = NSCollectionLayoutSupplementaryItem(
            layoutSize: supplementaryItemSize,
            elementKind: ElementKind.badge,
            containerAnchor: constraints
        )
        let itemSize = createItemSize(
            relativeWidth: 0.5,
            relativeHeight: 0.5
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [supplementaryItem])
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = createItemSize(
            relativeWidth: 1,
            relativeHeight: 0.3
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: ElementKind.background)
        sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 40, trailing: 10)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        section.decorationItems = [sectionBackgroundDecoration]
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    func createItemSize(relativeWidth: Double, relativeHeight: Double) -> NSCollectionLayoutSize {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(relativeWidth),
            heightDimension: .fractionalHeight(relativeHeight)
        )
        return size
    }
    
    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         booksArray[section].books.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return booksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell()}
        
        let bookType = booksArray[indexPath.section]
        let book = bookType.books[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
            let bookType = booksArray[indexPath.section]
            header.configure(bookType: bookType)
            return header
        } else if kind == ElementKind.badge {
            let badge = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeView.reuseIdentifier, for: indexPath) as! BadgeView
            
            let bookType = booksArray[indexPath.section]
            let book = bookType.books[indexPath.row]
            
            if book.isNew {
                badge.configureBadge(with: "New")
            } else {
                badge.isHidden = true
            }
            return badge
        }
        return UICollectionReusableView()
    }
}
