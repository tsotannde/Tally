//
//  DesignSystem.swift
//  Tally
//
//  Created by Adebayo Sotannde on 9/14/25.
//

import UIKit
import Hero
import SimplifiedAuthKit

enum DesignSystem //Design System
{
    enum AppColors 
    {
        static let primaryColor = UIColor(named: "Primary Color")!
        static let secondaryColor = UIColor(named: "Secondary Color")!
        static let errorColor = UIColor(named: "Error Color")!
        static let successColor = UIColor(named: "Success Color")!
        static let textPrimaryColor = UIColor(named: "Text Primary Color")!
        static let textSecondaryColor = UIColor(named: "Text Secondary Color")!
        static let backgroundColor = UIColor(named: "Background Color")!
        static let whiteColor = UIColor(named: "White Color")!
        
    }
    
    enum AppFonts
    {
        static let body = UIFont.systemFont(ofSize: 14)
        static let title = UIFont.boldSystemFont(ofSize: 24)
        static let loginPageFont: CGFloat = 70
        
        static func custom(_ name: String, size: CGFloat) -> UIFont 
        {
            UIFont(name: name, size: size) ?? .systemFont(ofSize: size)
        }
        
        enum FontName
        {
            static let AgbalumoRegular = "Agbalumo-Regular"
        }
    }
    
    enum Styling
    {
        enum LoginUI
        {
            static let sidePadding: CGFloat = 32//
            static let verticalSpacing: CGFloat = 16//
            static let buttonHeight: CGFloat = 50
            static let buttonCornerRadius: CGFloat = 8 //
            static let imagePadding: CGFloat = 8 //
            static let buttonCornerStyle: UIButton.Configuration.CornerStyle = .medium
            static let appleButtonType: ASAuthorizationAppleIDButton.ButtonType = .signIn
            static let appleButtonStyle: ASAuthorizationAppleIDButton.Style = .black
            static let borderWidth: CGFloat = 1
        }
    }
    
    enum AppImages
    {
        static let tallyTransparentImage = UIImage(named: "Tally Transparent")
        static let googleImage = UIImage(named: "googleLogo")
        static let envelope = UIImage(systemName: "envelope.fill")
    }
    
    enum SplashScreen
    {
        static let multiplier: CGFloat = 0.25
        static let postLaunchDelay: TimeInterval = 0.2
        
    }
    
    enum Animations 
    {
        static let splashToHome: HeroDefaultAnimationType = .zoomOut
        static let emailTransition: HeroDefaultAnimationType = .slide(direction: .left)
        static let loginTransition: HeroDefaultAnimationType = .slide(direction: .up)
        static let homeTransition: HeroDefaultAnimationType = .zoomOut
        static let slideLeftTransition: HeroDefaultAnimationType = .slide(direction: .left)
    }
    
    enum L10n
    {
        static let appNameKey = String(localized:  "app_name")
        static let loginWithEmailKey = String(localized: "login_with_email_text")
        static let signInWithGoogleKey =  String(localized:  "sign_in_google_text")
        static let skipKey = String(localized: "skip_text")
        static let loginTextKey = String(localized: "log_in_text")
        static let orseparatorKey = String(localized: "or_separator")
        static let emailPlaceHolderKey = String(localized: "email_placeholder")
        static let passwordPlaceholderKey = String(localized: "password_placeholder")
        static let incorrectPasswordKey = String(localized: "error_incorrect_password")
        static let forgotPasswordKey = String(localized:  "forgot_password_text")
        static let noAccountKey = String(localized: "no_account_question_Text")
        static let signupKey = String(localized: "sign_up_text")
       
    }
}
