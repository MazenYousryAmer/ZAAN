//
//  LoginPresenter.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 20/11/2025.
//

import Foundation

// MARK: - Login errors
enum LoginError: String {
    case NameEmptyError = "Please enter your email address"
    case PasswordEmptyError = "Please enter your password"
    case NameInvalidError = "Please enter a valid email address"
}

protocol LoginPresentationLogic: AnyObject {
    func presentInputError(error: LoginError)
    func presentLoginError(error: String)
    func presentSuccessfullLogin()
}

class LoginPresenter {
    
    //MARK: Variable
    var viewController: LoginViewController?
}

extension LoginPresenter: LoginPresentationLogic {
    func presentInputError(error: LoginError) {
        print(error.rawValue)
        viewController?.showError(error: error.rawValue)
    }
    
    func presentLoginError(error: String) {
        print(error)
        viewController?.showError(error: error)
    }
    
    func presentSuccessfullLogin() {
        viewController?.goTohome()
    }
}
