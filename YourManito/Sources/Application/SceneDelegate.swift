//
//  SceneDelegate.swift
//  YourManito
//
//  Created by 이자민 on 2/26/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Check if the user is already logged in
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            setHomeAsRootViewController()
        } else {
            setLoginAsRootViewController()
        }

        window?.makeKeyAndVisible()
    }
    
    func setLoginAsRootViewController() {
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }

    func setHomeAsRootViewController() {
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        
    }
}

