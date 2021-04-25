//
//  SceneDelegate.swift
//  2AM
//
//  Created by 전판근 on 2021/04/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //MARK:- RootViewController
//        guard let scene = (scene as? UIWindowScene) else { return }
//
//        window = UIWindow(windowScene: scene)
//        window?.rootViewController = HomeViewController()
//        window?.makeKeyAndVisible()
        
        //MARK:- TabBarViewController
        let tbc = UITabBarController()
        
        let view01 = HomeViewController()
        let view02 = MyPageViewController()
        
        tbc.setViewControllers([view01, view02], animated: false)
        
//        UITabBarItem(title: "메인", image: UIImage(systemName: "home"), tag: 0)
        view01.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        view02.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
//            UITabBarItem(title: "마이페이지", image: UIImage(systemName: "more": "more"), tag: 1)
        
        tbc.tabBar.backgroundColor = .brown
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        self.window?.rootViewController = tbc
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

