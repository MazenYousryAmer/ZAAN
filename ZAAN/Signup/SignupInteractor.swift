//
//  SignupInteractor.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 26/11/2025.
//

import Foundation
import FirebaseAuth

protocol RegisterInteractorProtocol: AnyObject {
    func shouldRegister(name: String?, password: String?, confirmPassword: String?) -> Bool
    func performRegister(name: String, password: String)
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
    func shouldRegister(name: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let name = name, !name.isEmpty else {
            presenter?.presentInputError(error: RegisterError.NameEmptyError, tag: 1)
            return false
        }
        guard let password = password, !password.isEmpty else {
            presenter?.presentInputError(error: RegisterError.PasswordEmptyError, tag: 2)
            return false
        }
        
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty, confirmPassword == password else {
            presenter?.presentInputError(error: RegisterError.PasswordNotMatchError, tag: 3)
            return false
        }
        
//        guard isValidEmail(name) else {
//            presenter?.presentInputError(error: LoginError.NameInvalidError)
//            return false
//        }
        return true
    }
    
    func performRegister(name: String, password: String) {
        Auth.auth().createUser(withEmail: name, password: password) { authResult, error in
          if let error = error {
            // Handle specific errors, e.g., weak password, email already in use
            print("Error creating user: \(error.localizedDescription)")
            return
          }
          // User registered successfully!
          if let user = authResult?.user {
            print("User registered: \(user.email ?? "N/A")")
            // Now you can access the user object and perform further actions
            // such as storing additional user data in Cloud Firestore or Firebase Data Connect.
          }
        }

    }
}
