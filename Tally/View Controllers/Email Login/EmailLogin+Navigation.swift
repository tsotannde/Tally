//
//  EmailLogin+Navigation.swift
//  Tally
//
//  Created by Developer on 9/17/25.
//

//MARK: - Naviagation Controller
extension EmailLoginViewController
{
    // Re-enable swipe-right to dismiss (Hero disables the default pop gesture)
    internal func configureSwipeBackGesture()
    {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
  
    // Replace the system back button with a custom one that triggers  Hero slide-right animation
    internal func replaceNavigationControllerBackButton() {
        navigationItem.hidesBackButton = true

        let backButton = UIButton(type: .system)
        backButton.addTarget(self, action: #selector(customBackPressed), for: .touchUpInside)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .white
        backButton.backgroundColor = DesignSystem.AppColors.secondaryColor
        backButton.layer.cornerRadius = 18
        backButton.clipsToBounds = true

        //padding so the background looks nice
        backButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        
        // Use it as a custom view inside UIBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // Handles custom back button press by popping the current view controller with a Hero slide-right animation via the NavigationManager.dismiss() function
    @objc private func customBackPressed()
    {
        NavigationManager.shared.dismiss(on: navigationController, animation: .slide(direction: .right), animated: true)
    }
}
