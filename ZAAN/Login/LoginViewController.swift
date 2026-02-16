//
//  LoginViewController.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 20/11/2025.
//

import UIKit

protocol LoginDisplayLogin: AnyObject {
    func showError(error: String)
    func goTohome()
}

class LoginViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var errorLabelheightConstraint: NSLayoutConstraint!
    @IBOutlet var loginButtonWidthAnimationConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var interactor: LoginInteractor!
    
    //MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //setupScene()
        setupCornerRadius()
        setupLocalizedText()
        hideLoading()
    }
    
    private func setupScene() {
//        let presenter = LoginPresenter(delegate: self)
//        let interactor = LoginInteractor(delegate: presenter)
//        self.interactor = interactor
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
    }
    
    private func setupCornerRadius() {
        self.usernameTextField.layer.cornerRadius = 25.0
        self.passwordTextField.layer.cornerRadius = 25.0
        self.loginButton.layer.cornerRadius = 25.0
        self.loadingActivityIndicator.layer.cornerRadius = 25.0
    }
    
    private func setupLocalizedText() {
        self.usernameTextField.placeholder = NSLocalizedString("login.username.placeholder", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("login.password.placeholder", comment: "")
        self.loginButton.titleLabel?.text = NSLocalizedString("login.login.button.title", comment: "")
    }
    
    private func showLoading() {
        loadingActivityIndicator.startAnimating()
    }
    
    private func hideLoading() {
        loadingActivityIndicator.stopAnimating()
    }
    
    private func showError(message: String) {
        errorLabel.text = message
        self.errorLabelheightConstraint.constant = 45
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideError() {
        self.errorLabelheightConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func showLoginButton() {
        self.hideLoading()
        self.loginButtonWidthAnimationConstraint.constant = (UIScreen.current?.bounds.size.width ?? 0.0) - 32.0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideLoginButton() {
        self.showLoading()
        self.loginButtonWidthAnimationConstraint.constant = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    //MARK: Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        showLoading()
        hideLoginButton()
        if interactor.shouldLogin(name: usernameTextField.text, password: passwordTextField.text) {
            interactor.performLogin(name: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(Factory().buildSignupScene(), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginViewController: LoginDisplayLogin {
    func showError(error: String) {
        hideLoading()
        showLoginButton()
        showError(message: error)
    }
    
    func goTohome() {
//        hideLoading()
//        hideError()
        print("here mazen")
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideError()
        hideLoading()
        showLoginButton()
    }
}
