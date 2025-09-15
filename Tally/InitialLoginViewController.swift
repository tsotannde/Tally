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
        print("InitalLogin View Controller")
       
        constructUserInterface()
    }
}

//MARK: - Create UserInterface
extension InitialLoginViewController
{
    private func makeTallyLabel() -> UILabel
    {
        let tallyLabel = UILabel()
        tallyLabel.text = DesignSystem.L10n.appNameKey
        tallyLabel.textColor = DesignSystem.AppColors.background
        tallyLabel.font = DesignSystem.AppFonts.custom(DesignSystem.AppFonts.FontName.AgbalumoRegular, size: DesignSystem.AppFonts.loginPageFont)
        tallyLabel.textAlignment = .center
        tallyLabel.translatesAutoresizingMaskIntoConstraints = false
        return tallyLabel
    }
    
    private func makeEmailButton() -> UIButton
    {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = DesignSystem.AppColors.background
        config.baseForegroundColor = DesignSystem.AppColors.textPrimary
        config.title =  DesignSystem.L10n.loginWithEmailKey
        config.image = DesignSystem.AppImages.envelope
        config.imagePadding = DesignSystem.Styling.LoginUI.imagePadding
        config.cornerStyle = DesignSystem.Styling.LoginUI.buttonCornerStyle
        config.background.strokeColor = DesignSystem.AppColors.background
        config.background.strokeWidth = DesignSystem.Styling.LoginUI.borderWidth
        
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleEmailSignIn), for: .touchUpInside)
        
        return button
    }
    
    private func makeGoogleButton() -> UIButton
    {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = DesignSystem.AppColors.background
        config.baseForegroundColor = DesignSystem.AppColors.textPrimary
        config.title = DesignSystem.L10n.signInWithGoogleKey
        config.image = DesignSystem.AppImages.googleImage?.withRenderingMode(.alwaysOriginal)
       
        config.imagePadding = DesignSystem.Styling.LoginUI.imagePadding
        config.cornerStyle = DesignSystem.Styling.LoginUI.buttonCornerStyle
        
        config.background.strokeColor =  DesignSystem.AppColors.background
        config.background.strokeWidth = DesignSystem.Styling.LoginUI.borderWidth
        
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        
        return button
    }
    
    private func makeAppleButton() -> ASAuthorizationAppleIDButton
    {
        let applebutton = SimplifiedAuthKit.styleAppleButton()
        applebutton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
        return applebutton
    }
    
    private func constructUserInterface()
    {
        // Background
        view.backgroundColor = DesignSystem.AppColors.primary
        
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
    }
    
   
}


//MARK: - User Authentificaton
extension InitialLoginViewController
{
    @objc func handleEmailSignIn()
    {
        NavigationManager.shared.navigate(to: EmailLoginViewController(), on: navigationController, clearStack: false, animation: DesignSystem.Animations.slideLeftTransition)
    }
    
    @objc func handleGoogleSignIn()
    {
        SimplifiedAuthKit.signInWithGoogle(from: self) { result in
            switch result {
            case .success(let user):
                print("✅ Signed in as \(user.uid)")
                // Navigate to Home
                NavigationManager.shared.navigate(
                    to: HomeViewController(),
                    on: self.navigationController,
                    clearStack: true,
                    animation: DesignSystem.Animations.slideLeftTransition
                )
            case .failure(let error):
                print("❌ Sign in failed: \(error.localizedDescription)")
                // Optionally show an alert
            }
        }
    }
    
    @objc func handleAppleSignIn() {
        SimplifiedAuthKit.signInWithApple(from: self) { result in
            switch result {
            case .success(let user):
                print("✅ Signed in as \(user.uid)")
                // Navigate to Home
                NavigationManager.shared.navigate(
                    to: HomeViewController(),
                    on: self.navigationController,
                    clearStack: true,
                    animation: DesignSystem.Animations.slideLeftTransition
                )
            case .failure(let error):
                print("❌ Sign in failed: \(error.localizedDescription)")
                // Optionally show an alert
            }
        }
    }
}
