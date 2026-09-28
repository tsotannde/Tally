//
//  InitialLoginViewController.swift
//
//
//  Created by Adebayo Sotannde on 9/15/25.
//

import UIKit
import SimplifiedAuthKit

class InitialLoginViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        constructUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        NavigationManager.shared.toggleNavigationBar(on: self.navigationController,animated: false, shouldShow: false)
    }
}

//MARK: - Create UserInterface
extension InitialLoginViewController
{
    private func makeSkipButton() -> UIButton
    {
        var config = UIButton.Configuration.plain()
        config.title = DesignSystem.L10n.skipKey
        config.baseForegroundColor = DesignSystem.AppColors.backgroundColor
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton(configuration: config)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }
    
    private func makeTallyLabel() -> UILabel
    {
        let tallyLabel = UILabel()
        tallyLabel.text = DesignSystem.L10n.appNameKey
        tallyLabel.textColor = DesignSystem.AppColors.backgroundColor
        tallyLabel.font = DesignSystem.AppFonts.custom(DesignSystem.AppFonts.FontName.AgbalumoRegular, size: DesignSystem.AppFonts.loginPageFont)
        tallyLabel.textAlignment = .center
        tallyLabel.translatesAutoresizingMaskIntoConstraints = false
        return tallyLabel
    }
    
    private func makeEmailButton() -> UIButton
    {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = DesignSystem.AppColors.backgroundColor
        config.baseForegroundColor = DesignSystem.AppColors.textPrimaryColor
        config.title =  DesignSystem.L10n.loginWithEmailKey
        config.image = DesignSystem.AppImages.envelope
        config.imagePadding = DesignSystem.Styling.LoginUI.imagePadding
        config.background.strokeWidth = DesignSystem.Styling.LoginUI.borderWidth
        
        let button = UIButton(configuration: config)
        button.addPressAnimation()
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleEmailSignIn), for: .touchUpInside)
        
        return button
    }
    
    private func makeGoogleButton() -> UIButton
    {
        let googleButton = SimplifiedAuthKit.makeAuthButton(for: .google, color: .white, adaptive: true)
        googleButton.addPressAnimation()
        googleButton.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return googleButton
    }
    
    private func makeAppleButton() -> UIButton
    {
        let appleButton = SimplifiedAuthKit.makeAuthButton(for: .apple, color: .black, adaptive: false)
        appleButton.addPressAnimation()
        appleButton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
        return appleButton
    }
    
    private func constructUserInterface()
    {
        // Background
        view.backgroundColor = DesignSystem.AppColors.primaryColor
        
        // Title Text label
        let tallyLabel = makeTallyLabel()
        view.addSubview(tallyLabel)
        
        //Buttons
        let emailButton = makeEmailButton()
        let googleButton = makeGoogleButton()
        let appleButton = makeAppleButton()
        
        // Buttons stack
        let buttonStack = UIStackView(arrangedSubviews: [emailButton, googleButton, appleButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = DesignSystem.Styling.LoginUI.verticalSpacing
        buttonStack.alignment = .fill
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        // Constraints
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.Styling.LoginUI.sidePadding),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.Styling.LoginUI.sidePadding),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -DesignSystem.Styling.LoginUI.sidePadding),
            
            emailButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight),
            googleButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight),
            appleButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight),
           
            tallyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.Styling.LoginUI.sidePadding),
            tallyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.Styling.LoginUI.sidePadding),
            tallyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DesignSystem.Styling.LoginUI.sidePadding),
            tallyLabel.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -DesignSystem.Styling.LoginUI.sidePadding)
        ])
        
        let skipButton = makeSkipButton()
        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17)
        ])
    }
}

//MARK: - User Authentificaton
extension InitialLoginViewController
{
    @objc func handleSkip()
    {
        NavigationManager.shared.navigate(to: FaceIDSetupViewController(),on: navigationController,clearStack: true,animation: DesignSystem.Animations.slideLeftTransition)
    }
    
    @objc func handleEmailSignIn()
    {
        NavigationManager.shared.navigate(to: EmailLoginViewController(), on: navigationController, clearStack: false, animation: DesignSystem.Animations.slideLeftTransition)
    }
    
    @objc func handleGoogleSignIn()
    {
        SimplifiedAuthKit.signIn(with: .google, from: self)
        { result in
            switch result
            {
            case .success(_):
                NavigationManager.shared.navigate(to: HomeViewController(),on: self.navigationController,clearStack: true,animation: DesignSystem.Animations.slideLeftTransition)
            case .failure(let error):
                let alert = UIAlertController(title: "Sign In Failed",message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func handleAppleSignIn()
    {
        SimplifiedAuthKit.signIn(with: .apple, from: self) { result in
            switch result
            {
            case .success(_):
                NavigationManager.shared.navigate(to: HomeViewController(),on: self.navigationController,clearStack: true,animation: DesignSystem.Animations.slideLeftTransition)
            case .failure(let error):
                let alert = UIAlertController(title: "Sign In Failed",message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                
            }
        }
    }
}

