//
//  AppDelegate.swift
//  Tally
//
//  Created by Adebayo Sotannde on 9/14/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    // Minimal AppDelegate:
    // Firebase is configured here at startup.
    // iOS default lifecycle behavior is acceptable since no overrides are needed.
    private let configureFirebase: Void =
    {
        FirebaseApp.configure() //Configure Firebase
    }()
}

