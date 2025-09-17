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
        static let primary = UIColor(named: "Primary")!
        static let secondary = UIColor(named: "Secondary")!
        static let error = UIColor(named: "Error")!
        static let success = UIColor(named: "Success")!
        static let textPrimary = UIColor(named: "Text Primary")!
        static let textSecondary = UIColor(named: "Text Secondary")!
        static let background = UIColor(named: "Background")!
        static let white = UIColor(named: "White")!
        
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
       
    }
}
