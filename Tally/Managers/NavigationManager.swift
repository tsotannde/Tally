//
//  NavigationManager.swift
//  Tally
//
//  Created by Adebayo Sotannde on 9/14/25.
//
import UIKit
import Hero

class NavigationManager
{
    static let shared = NavigationManager()
    
    private init() {}
    
    func toggleNavigationBar(on navigationController: UINavigationController?, animated: Bool = false, shouldShow: Bool = true) 
    {
        navigationController?.setNavigationBarHidden(!shouldShow, animated: animated)
    }
    
    func navigate(to viewController: UIViewController,on navigationController: UINavigationController?,clearStack: Bool = true,animation: HeroDefaultAnimationType? = nil)
    {
        if let animation = animation 
        {
            navigationController?.hero.isEnabled = true
            navigationController?.hero.navigationAnimationType = animation
        }
        
        if clearStack 
        {
            navigationController?.setViewControllers([viewController], animated: true)
        } else 
        {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func popViewController(animated: Bool = true, on navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: animated)
    }
}
