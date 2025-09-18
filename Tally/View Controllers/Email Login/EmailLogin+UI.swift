//
//  Email+UI.swift
//  Tally
//
//  Created by Developer on 9/17/25.
//


//MARK: - UI Component Builders
extension EmailLoginViewController
{
    internal  static func makeTitleLabel() -> UILabel
    {
        let label = UILabel()
        label.text = DesignSystem.L10n.loginTextKey
        label.textColor = DesignSystem.AppColors.textPrimaryColor
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    internal  static func makeAppleButton() -> UIButton
    {
        let appleButton = SimplifiedAuthKit.makeAuthButton(for: .apple,color: .black, adaptive: false)
        appleButton.addTarget(nil, action: #selector(appleTapped), for: .touchUpInside)
        appleButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        return appleButton
    }
    
    internal static func makeGoogleButton() -> UIButton
    {
        let googleButton = SimplifiedAuthKit.makeAuthButton(for: .google,color: .white, adaptive: true)
        googleButton.addTarget(nil, action: #selector(googleTapped), for: .touchUpInside)
        googleButton.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        googleButton.layer.borderWidth = DesignSystem.Styling.LoginUI.borderWidth
        googleButton.layer.borderColor = UIColor.black.cgColor 
        googleButton.layer.cornerRadius = DesignSystem.Styling.LoginUI.buttonCornerRadius
        googleButton.clipsToBounds = true
        return googleButton
    }
    
    internal static func makeOrLabel() -> UILabel
    {
        let label = UILabel()
        label.text = DesignSystem.L10n.orseparatorKey
        label.textColor = DesignSystem.AppColors.textPrimaryColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }
    
    internal static func makeEmailField() -> UITextField
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
        emailTextView.layer.borderColor = DesignSystem.AppColors.secondaryColor.cgColor
        emailTextView.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        return emailTextView
    }
    
    internal static func makeEmailErrorLabel() -> UILabel
    {
        let label = PaddedLabel()
        label.textColor = DesignSystem.AppColors.errorColor
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    internal static func makePasswordField() -> UITextField
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
        tf.layer.borderColor = DesignSystem.AppColors.secondaryColor.cgColor
        tf.heightAnchor.constraint(equalToConstant: DesignSystem.Styling.LoginUI.buttonHeight).isActive = true
        
        attachPasswordToggle(to: tf) // adds a right view to the password TextField
        
        return tf
    }
    
    internal static func attachPasswordToggle(to textField: UITextField)
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
    
    internal static func makePasswordErrorLabel() -> UILabel
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
    
    internal static func makeForgotPasswordButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        button.setTitle(DesignSystem.L10n.forgotPasswordKey, for: .normal)
        button.setTitleColor(DesignSystem.AppColors.secondaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.contentHorizontalAlignment = .right
        return button
    }
    
    internal static func makeLoginButton() -> UIButton
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
    
    internal static func makeBottomLabel() -> UILabel
    {
        let label = UILabel()
        label.text = DesignSystem.L10n.noAccountKey
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = DesignSystem.AppColors.textPrimaryColor
        return label
    }
    
    internal static func makeSignUpButton() -> UIButton
    {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.setTitle(DesignSystem.L10n.signupKey, for: .normal)
        button.setTitleColor(DesignSystem.AppColors.secondaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return button
    }
}

extension EmailLoginViewController
{
    internal func setupUI()
    {
        view.backgroundColor = DesignSystem.AppColors.whiteColor
        
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
