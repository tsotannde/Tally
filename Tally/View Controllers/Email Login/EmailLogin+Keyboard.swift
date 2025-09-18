//
//  Email+Keyboard.swift
//  Tally
//
//  Created by Developer on 9/17/25.
//


//MARK: - Keyboard Dismissal
extension EmailLoginViewController
{
    //Recognizes when the user taps the screen
    internal func dismissKeyboardGesture()
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
