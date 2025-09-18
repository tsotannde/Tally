//
//  FaceIDSetupViewController.swift
//  Tally
//
//  Created by Developer on 9/17/25.
//

import UIKit

import UIKit

class FaceIDSetupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        // Face ID Icon
        let faceIDIcon = UIImageView(image: UIImage(systemName: "faceid"))
        faceIDIcon.tintColor = .systemBlue
        faceIDIcon.contentMode = .scaleAspectFit
        faceIDIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Log in with Face ID"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Subtitle Label
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Once you enable Face ID, you won't need to type in your password to log in."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Enable Face ID Button
        let enableButton = UIButton(type: .system)
        enableButton.setTitle("Enable Face ID", for: .normal)
        enableButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        enableButton.backgroundColor = .systemBlue
        enableButton.setTitleColor(.white, for: .normal)
        enableButton.layer.cornerRadius = 8
        enableButton.translatesAutoresizingMaskIntoConstraints = false
        enableButton.addTarget(self, action: #selector(handleEnableFaceID), for: .touchUpInside)
        
        // Skip Button
        let skipButton = UIButton(type: .system)
        skipButton.setTitle("Not now", for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        skipButton.setTitleColor(.systemBlue, for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        // Stack
        let stack = UIStackView(arrangedSubviews: [faceIDIcon, titleLabel, subtitleLabel, enableButton, skipButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            faceIDIcon.heightAnchor.constraint(equalToConstant: 80),
            faceIDIcon.widthAnchor.constraint(equalToConstant: 80),
            
            enableButton.heightAnchor.constraint(equalToConstant: 50),
            enableButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            skipButton.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])
    }
    
    @objc private func handleEnableFaceID() {
        print("Enable Face ID tapped")
        // TODO: Hook into Face ID registration flow
    }
    
    @objc private func handleSkip() {
        print("Skip tapped")
        dismiss(animated: true, completion: nil)
    }
}
