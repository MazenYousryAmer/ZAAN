//
//  SignupPresenter.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 26/11/2025.
//

import Foundation

// MARK: - Register errors
enum RegisterError: String {
    case FirstNameEmptyError = "register.first.name.error.empty"
    case LastNameEmptyError = "register.last.name.error.empty"
    case EmailEmptyError = "register.email.address.error.empty"
    case EmailInvalidError = "register.email.address.error.invalid"
    case PasswordEmptyError = "register.password.error.empty"
    case PasswordNotMatchError = "register.confirm.password.error.empty"
    
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
