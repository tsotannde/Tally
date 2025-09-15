//
//  SplashViewController.swift
//  Tally
//
//  Created by Adebayo Sotannde on 9/14/25.
//

import UIKit
import Hero
import SimplifiedAuthKit


final class SplashViewController: UIViewController
{
    enum LaunchDestination
    {
        case home
        case login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SimplifiedAuthKit.signOut()
        SimplifiedAuthKit.observeAuthChanges { user in
              if let user = user {
                  print("➡️ Navigate to Home:")
              } else {
                  print("➡️ Navigate to Login")
              }
          }
    }
    
    
       
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        NavigationManager.shared.toggleNavigationBar(on: navigationController,animated: false, shouldShow: false)
    }
    
}
    
       
