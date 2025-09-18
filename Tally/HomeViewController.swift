//
//  HomeViewController.swift
//  
//
//  Created by Adebayo Sotannde on 9/15/25.
//

import UIKit
import SimplifiedAuthKit

class HomeViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Home View Controller")
        view.backgroundColor = .purple

        let signOutButton = UIButton(type: .system)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        view.addSubview(signOutButton)

        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func signOutTapped() {
        SimplifiedAuthKit.signOut()
    }
}
