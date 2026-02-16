//
//  Factory.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 10/02/2026.
//

import Foundation
import UIKit

class Factory {
    
    func buildLoginScene() -> LoginViewController {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        return viewController
    }
    
    func buildSignupScene() -> SignupViewController {
        let viewController = SignupViewController()
        let presenter = SignupPresenter()
        let interactor = SignupInteractor()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        return viewController
    }
}
