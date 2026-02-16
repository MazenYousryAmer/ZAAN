//
//  LoginInteractor.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 20/11/2025.
//

import Foundation
import FirebaseAuth

protocol LoginInteractorProtocol: AnyObject {
    func shouldLogin(name: String?, password: String?) -> Bool
    func performLogin(name: String, password: String)
}

class LoginInteractor {
    
    //MARK: variable
    var presenter: LoginPresenter?
    
//    init(delegate: LoginPresentationLogic?) {
//        self.presenter = delegate
//    }
    
    //MARK: functions
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    func shouldLogin(name: String?, password: String?) -> Bool {
        guard let name = name, !name.isEmpty else {
            presenter?.presentInputError(error: LoginError.NameEmptyError)
            return false
        }
        guard let password = password, !password.isEmpty else {
            presenter?.presentInputError(error: LoginError.PasswordEmptyError)
            return false
        }
        
        guard isValidEmail(name) else {
            presenter?.presentInputError(error: LoginError.NameInvalidError)
            return false
        }
        return true
    }
    
    func performLogin(name: String, password: String) {
        FireBaseAuthWorker().login(name: name, password: password, completion: {[weak self] result in
            switch result {
            case.success(let response):
                print("User signed in: \(response.user.email ?? "N/A")")
                self?.presenter?.presentSuccessfullLogin()
            case .failure(let error):
                print("Error signing in: \(error.localizedDescription)")
                self?.presenter?.presentLoginError(error: error.localizedDescription)
            }
        })
    }
}
