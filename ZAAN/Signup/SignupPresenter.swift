//
//  SignupPresenter.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 26/11/2025.
//

import Foundation

// MARK: - Register errors
enum RegisterError: String {
    case NameEmptyError = "Please enter your email address"
    case NameInvalidError = "Please enter a valid email address"
    case PasswordEmptyError = "Please enter your password"
    case PasswordNotMatchError = "Password does not match"
}

protocol RegisterPresentationLogic: AnyObject {
    func presentInputError(error: RegisterError, tag:Int)
    func presentRegisterError(error: String)
    func presentSuccessfullRegister()
}

class SignupPresenter {
    
    //MARK: Variable
    var viewController: SignupViewController?
}

extension SignupPresenter: RegisterPresentationLogic {
    func presentInputError(error: RegisterError, tag:Int) {
        print(error.rawValue)
        viewController?.showError(error: error.rawValue, tag: tag)
    }
    
    func presentRegisterError(error: String) {
        
    }
    
    func presentSuccessfullRegister() {
        
    }
    
    
}
