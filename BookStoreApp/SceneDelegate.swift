//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by user on 12.12.2024.
//

import UIKit

enum Scene {
    case viewController
    case sectionProvider
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        //window?.rootViewController = UINavigationController(rootViewController: assembly(scene: .viewController))
        window?.rootViewController = UINavigationController(rootViewController: TabBarController())
        window?.makeKeyAndVisible()
        
    }

    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
    
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}


extension SceneDelegate {
    func assembly(scene: Scene) -> UIViewController {
        let booksType = BookTypeManager()
        switch scene {
        case .viewController:
            return ViewController(bookManager: booksType)
        case .sectionProvider:
            return MultipleSectionsViewController()
        }
    }
}
