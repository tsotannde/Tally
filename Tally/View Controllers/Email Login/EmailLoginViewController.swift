//
//  EmailLoginViewController.swift
//  
//
//  Created by Developer on 9/15/25.
//

@_exported import UIKit
@_exported import Hero
@_exported import SimplifiedAuthKit

final class EmailLoginViewController: UIViewController
{
    //UI Components
    internal let titleLabel = makeTitleLabel()
    internal let appleButton = makeAppleButton()
    internal let googleButton = makeGoogleButton()
    internal let orLabel = makeOrLabel()
    internal var emailCheckmarkView: UIImageView?
    internal let emailTextField = makeEmailField()
    internal let emailErrorLabel = makeEmailErrorLabel()
    internal var passwordCheckmarkView: UIImageView?
    internal let passwordTextField = makePasswordField()
    internal let passwordErrorLabel = makePasswordErrorLabel()
    internal let forgotButton = makeForgotPasswordButton()
    internal let loginButton = makeLoginButton()
    internal let bottomLablel = makeBottomLabel()
    internal let signUpButton = makeSignUpButton()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dismissKeyboardGesture() // Dismiss keyboard when tapping anywhere on the main view
        setupUI() //Construct the User Interface
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        replaceNavigationControllerBackButton() // Use custom back button instead of the default one
        NavigationManager.shared.toggleNavigationBar(on: self.navigationController,animated: false, shouldShow: true)
        configureSwipeBackGesture()
    }
}

// MARK: - Actions
extension EmailLoginViewController
{
    @objc func googleTapped()
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
    
    @objc func appleTapped()
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
    
    @objc internal func LoginButtonTapped()
    {
        print("Login  Tapper")
    }
    @objc internal func signUpButtonTapped()
    {
        NavigationManager.shared.navigate(to: EmailSignupViewController(), on: self.navigationController,clearStack: false, animation: DesignSystem.Animations.slideLeftTransition)
    }
    @objc internal func forgotPasswordTapped()
    {
        print("Forgot passworf button tapped ")
    }
    
}

extension EmailLoginViewController
{
    
    public func toggleValidationLabel(_ label: UILabel, isValid: Bool, message: String? = nil)
    {
        DispatchQueue.main.async //Update UI on Main Thread
        {
            if let message = message
            {
                label.text = message
            }
            
            if isValid
            {
                // Always update immediately first
                label.isHidden = true
                label.text = nil
                           
            } else {
                label.isHidden = false
                label.alpha = 1.0
                
            }
        }
    }
    
    
    
    public func indicateValidationTextField(on textField: UITextField, isValid: Bool, persist: Bool = false) {
        DispatchQueue.main.async
        {
            if isValid
            {
                textField.layer.borderColor = DesignSystem.AppColors.successColor.cgColor
                self.emailCheckmarkView = self.toggleCheckmark(for: self.emailTextField, isValid: true )
                
                
            } else
            {
                textField.layer.borderColor = DesignSystem.AppColors.errorColor.cgColor
                
                
                if !persist
                {
                    let originalColor = DesignSystem.AppColors.textPrimaryColor.cgColor
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                    {
                        textField.layer.borderColor = originalColor
                    }
                }
                
                // Inline shake
                let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
                animation.timingFunction = CAMediaTimingFunction(name: .linear)
                animation.duration = 0.4
                animation.values = [-10, 10, -8, 8, -5, 5, 0]
                textField.layer.add(animation, forKey: "shake")
                //            }
            }
        }
    }
    
//    private func toggleCheckmark(for checkmarkView: UIImageView?, isValid: Bool)
//    {
//        guard let checkmarkView = checkmarkView else { return }
//
//        UIView.transition(with: checkmarkView,
//                          duration: 0.7,
//                          options: .transitionCrossDissolve,
//                          animations:
//                            {
//            checkmarkView.isHidden = !isValid
//        })
//    }
    
    private func toggleCheckmark(for textField: UITextField, isValid: Bool) -> UIImageView {
        let checkmark = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        checkmark.tintColor = .systemGreen
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        checkmark.isHidden = true
        view.addSubview(checkmark)
        
        NSLayoutConstraint.activate([
            checkmark.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            checkmark.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -25),
            checkmark.widthAnchor.constraint(equalToConstant: 20),
            checkmark.heightAnchor.constraint(equalToConstant: 20)
        ])
        UIView.transition(with: checkmark,
                                  duration: 0.7,
                                  options: .transitionCrossDissolve,
                                  animations:
                                    {
            checkmark.isHidden = !isValid
                })
        
        return checkmark
    }
    
    //Resets the border
    public func resetBorder(on textField: UITextField)
    {
        textField.layer.borderColor  = DesignSystem.AppColors.textPrimaryColor.cgColor
    }
}


