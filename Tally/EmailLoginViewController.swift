//
//  EmailLoginViewController.swift
//  
//
//  Created by Developer on 9/15/25.
//

import UIKit
import Hero
import SimplifiedAuthKit

final class EmailLoginViewController: UIViewController
{
    //UI Components
    private let titleLabel = makeTitleLabel()
    private let appleButton = makeAppleButton()
    private let googleButton = makeGoogleButton()
    private let orLabel = makeOrLabel()
    private var emailCheckmarkView: UIImageView?
    private let emailTextField = makeEmailField()
    private let emailErrorLabel = makeEmailErrorLabel()
    private var passwordCheckmarkView: UIImageView?
    private let passwordTextField = makePasswordField()
    private let passwordErrorLabel = makePasswordErrorLabel()
    private let forgotButton = makeForgotPasswordButton()
    private let loginButton = makeLoginButton()
    private let bottomLablel = makeBottomLabel()
    private let signUpButton = makeSignUpButton()
    
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

//MARK: - Naviagation Controller
extension EmailLoginViewController
{
    // Re-enable swipe-right to dismiss (Hero disables the default pop gesture)
    private func configureSwipeBackGesture()
    {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
  
    // Replace the system back button with a custom one that triggers  Hero slide-right animation
    private func replaceNavigationControllerBackButton()
    {
        navigationItem.hidesBackButton = true //Hides the Back Button created by the Navigation Controller
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),style: .plain,target: self,action: #selector(customBackPressed))
    }
    
    // Handles custom back button press by popping the current view controller with a Hero slide-right animation via the NavigationManager.dismiss() function
    @objc private func customBackPressed()
    {
        NavigationManager.shared.dismiss(on: navigationController, animation: .slide(direction: .right), animated: true)
    }
}

//MARK: - Keyboard Dismissal
extension EmailLoginViewController
{
    //Recognizes when the user taps the screen
    func dismissKeyboardGesture()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    //Dismiss the keyboard by actually Ending editing
    @objc private func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

//MARK: - UI Component Builders
extension EmailLoginViewController
{
    public static func makeTitleLabel() -> UILabel
    {
        let label = UILabel()
        label.text = DesignSystem.L10n.loginTextKey
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private  static func makeAppleButton() -> UIButton
    {
        let appleButton = SimplifiedAuthKit.makeAuthButton(for: .apple,color: .black, adaptive: false)
        appleButton.addTarget(nil, action: #selector(appleTapped), for: .touchUpInside)
        appleButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        return appleButton
    }
    
    private static func makeGoogleButton() -> UIButton
    {
        let googleButton = SimplifiedAuthKit.makeAuthButton(for: .google,color: .white, adaptive: true)
        googleButton.addTarget(nil, action: #selector(googleTapped), for: .touchUpInside)
        googleButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        googleButton.tintColor = .red
        return googleButton
    }
    
    private static func makeOrLabel() -> UILabel
    {
        let label = UILabel()
        label.text = DesignSystem.L10n.orseparatorKey
        label.textColor = DesignSystem.AppColors.textPrimaryColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }
    
    private static func makeEmailField() -> UITextField
    {
        let emailTextView = UITextField()
        emailTextView.placeholder = DesignSystem.L10n.emailPlaceHolderKey
        emailTextView.font = UIFont.systemFont(ofSize: 16)
        emailTextView.autocapitalizationType = .none
        emailTextView.keyboardType = .emailAddress
        emailTextView.autocorrectionType = .no
        emailTextView.backgroundColor = DesignSystem.AppColors.backgroundColor
        emailTextView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        emailTextView.leftViewMode = .always
        emailTextView.layer.cornerRadius = DesignSystem.Styling.LoginUI.buttonCornerRadius
        emailTextView.layer.borderWidth = DesignSystem.Styling.LoginUI.borderWidth
        emailTextView.layer.borderColor = DesignSystem.AppColors.textPrimaryColor.cgColor
        emailTextView.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        return emailTextView
    }
    
    private static func makeEmailErrorLabel() -> UILabel
    {
        let label = PaddedLabel()
        label.textColor = DesignSystem.AppColors.errorColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private static func makePasswordField() -> UITextField
    {
        let tf = UITextField()
        tf.placeholder = DesignSystem.L10n.passwordPlaceholderKey
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.autocapitalizationType = .none
        tf.textContentType = .password
        tf.autocorrectionType = .no
        tf.smartQuotesType = .no
        tf.isSecureTextEntry = true
        tf.backgroundColor = DesignSystem.AppColors.backgroundColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = DesignSystem.Styling.LoginUI.buttonCornerRadius
        tf.layer.borderWidth = DesignSystem.Styling.LoginUI.borderWidth
        tf.layer.borderColor = DesignSystem.AppColors.textPrimaryColor.cgColor
        tf.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        
        attachPasswordToggle(to: tf) // adds a right view to the password TextField
        
        return tf
    }
    
    private static func attachPasswordToggle(to textField: UITextField)
    {
        let toggleButton = UIButton(type: .system)
        toggleButton.tintColor = DesignSystem.AppColors.secondaryColor
        
        let symbolCfg = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular, scale: .medium)
        toggleButton.setPreferredSymbolConfiguration(symbolCfg, forImageIn: .normal)
        toggleButton.setImage(UIImage(systemName: "eye", withConfiguration: symbolCfg), for: .normal)
        
        toggleButton.addAction(UIAction { _ in
            let wasFirstResponder = textField.isFirstResponder
            let selected = textField.selectedTextRange
            
            textField.isSecureTextEntry.toggle()
            let name = textField.isSecureTextEntry ? "eye" : "eye.slash"
            toggleButton.setImage(UIImage(systemName: name, withConfiguration: symbolCfg), for: .normal)
            
            if wasFirstResponder
            { textField.becomeFirstResponder()
            }
            if let selected = selected
            { textField.selectedTextRange = selected
            }
        }, for: .touchUpInside)
        
        // Wrap in container with padding
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 55, height:30 )) // wider than button
        container.backgroundColor = .clear
        toggleButton.frame = CGRect(x: 5, y: 0, width: 30, height: 30)          // inset inside container
        container.addSubview(toggleButton)
        
        textField.rightView = container
        textField.rightViewMode = .always
    }
    
    private static func makePasswordErrorLabel() -> UILabel
    {
        let label = PaddedLabel()
        label.text = DesignSystem.L10n.incorrectPasswordKey
        label.textColor = DesignSystem.AppColors.errorColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }
    
    private static func makeForgotPasswordButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        button.setTitle(DesignSystem.L10n.forgotPasswordKey, for: .normal)
        button.setTitleColor(DesignSystem.AppColors.secondaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.contentHorizontalAlignment = .right
        return button
    }
    
    private static func makeLoginButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(LoginButtonTapped), for: .touchUpInside)
        button.setTitle(DesignSystem.L10n.loginWithEmailKey, for: .normal)
        button.backgroundColor = DesignSystem.AppColors.secondaryColor
        button.setTitleColor(DesignSystem.AppColors.backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = DesignSystem.Styling.LoginUI.buttonCornerRadius
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }
}


extension EmailLoginViewController
{
    private static func makeBottomLabel() -> UILabel
    {
        let label = UILabel()
        label.text = DesignSystem.L10n.noAccountKey
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = DesignSystem.AppColors.textPrimaryColor
        return label
    }
    
    private static func makeSignUpButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.setTitle(DesignSystem.L10n.signupKey, for: .normal)
        button.setTitleColor(DesignSystem.AppColors.secondaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return button
    }
    
    private func setupUI()
    {
        view.backgroundColor = DesignSystem.AppColors.backgroundColor
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        
        DispatchQueue.main.async
        {
            self.emailTextField.becomeFirstResponder()
        }
        
        
        
        
        
        let passworErrorStack = UIStackView(arrangedSubviews: [passwordErrorLabel, UIView(), forgotButton])
        passworErrorStack.axis = .horizontal
        passworErrorStack.alignment = .center
        passworErrorStack.spacing = 0
        passworErrorStack.isLayoutMarginsRelativeArrangement = true
        
        let bottomStack = UIStackView(arrangedSubviews: [bottomLablel, signUpButton])
        
        bottomStack.axis = .horizontal
        bottomStack.spacing = 4
        bottomStack.alignment = .center
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStack) //Add to View
        bottomLablel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        signUpButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Main vertical stack
        let authFieldsStack = UIStackView(arrangedSubviews: [
            titleLabel,
            appleButton,
            googleButton,
            orLabel,
            emailTextField,
            emailErrorLabel,
            passwordTextField,
            passworErrorStack,
            loginButton
        ])
        
        
        authFieldsStack.axis = NSLayoutConstraint.Axis.vertical
        authFieldsStack.spacing = 20
        authFieldsStack.setCustomSpacing(10, after: emailTextField)
        authFieldsStack.setCustomSpacing(10, after: emailErrorLabel)
        authFieldsStack.setCustomSpacing(8, after: passwordTextField)
        authFieldsStack.setCustomSpacing(8, after: passworErrorStack)
        authFieldsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authFieldsStack)
        
     
        NSLayoutConstraint.activate([
            authFieldsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            authFieldsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            authFieldsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
    
            
            
            bottomStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
        ])
        

        
        
        //Check Mark
        let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        checkmarkImageView.tintColor = .systemGreen
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.isHidden = true
        view.addSubview(checkmarkImageView)
        
        // Pin to trailing edge of emailTextField
        NSLayoutConstraint.activate([
            checkmarkImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: -25),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        // Keep a reference
        self.emailCheckmarkView = checkmarkImageView

    }
    
}

// MARK: - UITextFieldDelegate methods for handling Return key behavior
extension EmailLoginViewController: UITextFieldDelegate
{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == emailTextField
        {
            // Move focus to the password text field when Return is pressed on the email field
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField
        {
            // Trigger login validation when Return is pressed on the password field
        }
        return true
    }
}

// MARK: - Actions
extension EmailLoginViewController
{
    @objc func googleTapped()
    {
       // AuthenticationManager.shared.startGoogleSignIn(from: self)
    }
    
    @objc func appleTapped()
    {
       // AuthenticationManager.shared.startAppleSignIn(from: self)
    }
    
    @objc private func LoginButtonTapped() { didTapLogInWithEmailButton()}
    @objc private func signUpButtonTapped() { didTapSignUp()}
    @objc private func forgotPasswordTapped() {didTapForgotPassword()}
    
    //User Clicked the login Button
    private func didTapLogInWithEmailButton()
    {
        print("LoginButton Tapper")
    }
    
    //user taps the signup button
    private func didTapSignUp()
    {
        print("SignupButton Tapper")
    }
    
    //uer tapped the forgot passsword button
    private func didTapForgotPassword()
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


