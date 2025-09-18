//
//  EmailLogin+TextField.swift
//  Tally
//
//  Created by Developer on 9/17/25.
//


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
            LoginButtonTapped()
        }
        return true
    }
}
