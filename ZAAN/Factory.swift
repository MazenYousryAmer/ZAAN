//
//  Factory.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 10/02/2026.
//

import Foundation
import UIKit

class Factory {
    
    func buildLoginScene() -> UINavigationController {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let navigation = loginStoryboard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
        let viewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        navigation.viewControllers = [viewController]
        return navigation
    }
    
    func buildSignupScene() -> SignupViewController {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = loginStoryboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        let presenter = SignupPresenter()
        let interactor = SignupInteractor()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        return viewController
    }
}
