//
//  SceneDelegate.swift
//  Tally
//
//  Created by Developer on 9/14/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?
    
    func scene(_ scene: UIScene,willConnectTo session: UISceneSession,options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        let root = ViewController()
        let nav = UINavigationController(rootViewController: root)
        window.rootViewController = nav

        self.window = window
        window.makeKeyAndVisible()
    }
}
