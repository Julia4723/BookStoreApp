//
//  MultipleSectionsViewController.swift
//  BookStoreApp
//
//  Created by user on 16.12.2024.
//

import UIKit

final class MultipleSectionsViewController: UIViewController {
    //MARK: - Private property
    private let reuseIdentifier = "reuseIdentifier"
    private var collectionView: UICollectionView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        configureCollectionView()
        
    }
}

//MARK: - Setup View
private extension MultipleSectionsViewController {
    func setupView() {
        let layout = createLayout()
        
        layout.register(
            SectionBackgroundDecoration.self,
            forDecorationViewOfKind: ElementKind.background
        )
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(
            SectionHeaderView2.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView2.reuseIdentifier
        )
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
}

//MARK: - Layout settings
private extension MultipleSectionsViewController {
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment in
            
            let containerWidth = enviroment.container.effectiveContentSize.width
            
            if sectionIndex == 0 {
                return self.createTopSection()
            } else if sectionIndex == 1 {
                return self.createMiddleSection(containerWidth: containerWidth)
            } else {
                return self.createBottomSection()
            }
        }
    }
    
    func createTopSection() -> NSCollectionLayoutSection {
        //задаем размер каждого item в группе
        let itemSection = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(100)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSection)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //задаем высоту группы (фиксирована), ширина
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(1),
            heightDimension: .absolute(100)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        //кладем группу в секцию
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createHeader()]
        return section
        
    }
    
    func createMiddleSection(containerWidth: CGFloat) -> NSCollectionLayoutSection {
        let itemSection = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSection)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(180),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [createHeader()]
        return section
    }
    
    func createBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeader()]
        return section
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return header
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
extension MultipleSectionsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            8
        } else if section == 1 {
            6
        } else {
            3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
            cell.layer.cornerRadius = cell.frame.width / 2
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen
            cell.layer.cornerRadius = 10
        } else {
            cell.backgroundColor = .systemIndigo
            cell.layer.cornerRadius = 10
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView2.reuseIdentifier, for: indexPath) as! SectionHeaderView2
            header.configure(text: "Section \(indexPath.section + 1)")
            return header
            
        }
        return UICollectionViewCell()
    }
}


