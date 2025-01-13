//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by user on 12.01.2025.
//

import UIKit

enum BarItems {
    case main
    case search
    
    var title: String {
        switch self {
        case .main:
            return "Main"
        case .search:
            return "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "house.fill")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        }
    }
}




class TabBarController: UITabBarController {
    //MARK: - Private property
    private let dataSource: [BarItems] = [.main, .search]
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTabBarControllers()
        setupTabBar()
    }
    
}

private extension TabBarController {
    func buildTabBarControllers() {
        var controllers: [UIViewController] = []
        let booksType = BookTypeManager()
        
        for item in dataSource {
            switch item {
            case .main:
                let viewController = UINavigationController(rootViewController: ViewController(bookManager: booksType))
                controllers.append(viewController)
            case .search:
                let viewController = UINavigationController(rootViewController: MultipleSectionsViewController())
                controllers.append(viewController)
            }
        }
        
        viewControllers = controllers
    }
    
    func setupTabBar() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        viewControllers?.enumerated().forEach{ index, viewController in
            viewController.tabBarItem.title = dataSource[index].title
            viewController.tabBarItem.image = dataSource[index].icon
        }
    }
}
