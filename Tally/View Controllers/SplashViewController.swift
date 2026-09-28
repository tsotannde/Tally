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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        navigateToDestination()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        NavigationManager.shared.toggleNavigationBar(on: navigationController,animated: false, shouldShow: false)
    }
}
//MARK: - Create the UI Helper Functions
extension SplashViewController
{
    private func setupUI()
    {
        view.backgroundColor = DesignSystem.AppColors.primaryColor

        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        logo.image = DesignSystem.AppImages.tallyTransparentImage

        view.addSubview(logo)

        let multiplier = 0.25
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            logo.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                        multiplier: multiplier),
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor)
        ])
    }
}
     
//MARK: - Navigation Launch Destinations Helper Functions
extension SplashViewController
{
    private func navigateToDestination()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + DesignSystem.SplashScreen.postLaunchDelay)
        { [weak self] in
            
            guard let self = self else { return }
            
            let destination: LaunchDestination = SimplifiedAuthKit.isSignedIn() ? .home : .login
            
            switch destination
            {
            case .login:
                NavigationManager.shared.navigate(to: InitialLoginViewController(), on: navigationController,clearStack: true, animation: DesignSystem.Animations.loginTransition)
            case .home:
                NavigationManager.shared.navigate(to: HomeViewController(), on: navigationController,clearStack: true,animation: DesignSystem.Animations.homeTransition)
            }
        }
    }
}

