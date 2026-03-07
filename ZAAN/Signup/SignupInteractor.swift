//
//  SignupInteractor.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 26/11/2025.
//

import Foundation
import FirebaseAuth

protocol RegisterInteractorProtocol: AnyObject {
//    func shouldRegister(name: String?, password: String?, confirmPassword: String?) -> Bool
    
    func shouldRegister(firstName: String?, lastName: String?, email: String?, password: String?, confirmPassword: String?) -> Bool
    func performRegister(email: String, password: String)
}

class SignupInteractor {
    
    //MARK: variable
    var presenter: SignupPresenter?
    
    //MARK: functions
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

extension SignupInteractor: RegisterInteractorProtocol {
    func shouldRegister(firstName: String?, lastName: String?, email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let firstName = firstName, !firstName.isEmpty else {
            presenter?.presentInputError(error: RegisterError.FirstNameEmptyError, tag: 1)
            return false
        }
        guard let lastName = lastName, !lastName.isEmpty else {
            presenter?.presentInputError(error: RegisterError.LastNameEmptyError, tag: 2)
            return false
        }
        guard let email = email, !email.isEmpty else {
            presenter?.presentInputError(error: RegisterError.EmailEmptyError, tag: 3)
            return false
        }
        guard isValidEmail(email) else {
            presenter?.presentInputError(error: RegisterError.EmailInvalidError, tag: 3)
            return false
        }
        guard let password = password, !password.isEmpty else {
            presenter?.presentInputError(error: RegisterError.PasswordEmptyError, tag: 4)
            return false
        }
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty, confirmPassword == password else {
            presenter?.presentInputError(error: RegisterError.PasswordNotMatchError, tag: 5)
            return false
        }
        return true

    }
    
    func performRegister(email: String, password: String) {
        FireBaseAuthWorker().register(email: email, password: password, completion: {[weak self] result in
            switch result {
            case.success(let response):
                print("User signed in: \(response.user.email ?? "N/A")")
                self?.presenter?.presentSuccessfullRegister()
            case .failure(let error):
                print("Error signing in: \(error.localizedDescription)")
                self?.presenter?.presentRegisterError(error: error.localizedDescription)
            }
        })
    }
}
