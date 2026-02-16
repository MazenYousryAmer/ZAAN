//
//  SignupViewController.swift
//  ZAAN
//
//  Created by Mazen Amer, Vodafone on 25/11/2025.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func showError(error: String, tag: Int)
    func goTohome()
}

class SignupViewController: UIViewController {
    
    //MARK: Iboutlets
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var usernameErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!
    @IBOutlet var confirmPasswordErrorLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    //MARK: Variables
    var interactor: SignupInteractor!

    //MARK: view methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupScene()
        setupLocalizedText()
        setupCornerRadius()
        hideErrorLabels()
    }
    
    private func setupLocalizedText() {
        self.usernameTextField.placeholder = NSLocalizedString("register.username.placeholder", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("register.password.placeholder", comment: "")
        self.confirmPasswordTextField.placeholder = NSLocalizedString("register.confirm.password.placeholder", comment: "")
        self.registerButton.setTitle(NSLocalizedString("register.register.button.title", comment: ""), for: .normal)
    }
    
    private func setupCornerRadius() {
        self.usernameTextField.layer.cornerRadius = 25.0
        self.passwordTextField.layer.cornerRadius = 25.0
        self.confirmPasswordTextField.layer.cornerRadius = 25.0
        self.registerButton.layer.cornerRadius = 25.0
    }
    
    private func hideErrorLabels() {
        self.usernameErrorLabel.isHidden = true
        self.passwordErrorLabel.isHidden = true
        self.confirmPasswordErrorLabel.isHidden = true
    }
    
//    private func showError(message: String, tag: Int) {
//        hideErrorLabels()
//        guard let label = self.view.viewWithTag(tag) as? UILabel else { return }
//        label.isHidden = false
//        label.text = message
//    }
    
    private func setupScene() {
//        let presenter = LoginPresenter(delegate: self)
//        let interactor = LoginInteractor(delegate: presenter)
//        self.interactor = interactor
        let presenter = SignupPresenter()
        let interactor = SignupInteractor()
        presenter.viewController = self
        interactor.presenter = presenter
        self.interactor = interactor
    }
    
    
    //MARK: Ibaction
    @IBAction func signupButtonPressed(_ sender: Any) {
        if interactor.shouldRegister(name: usernameTextField.text ?? "", password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "") {
            interactor.performRegister(name: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        }
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

extension SignupViewController: RegisterDisplayLogic {
    func showError(error: String, tag: Int) {
        hideErrorLabels()
        switch tag {
        case 1:
            self.usernameErrorLabel.isHidden = false
            self.usernameErrorLabel.text = error
        case 2:
            self.passwordErrorLabel.isHidden = false
            self.passwordErrorLabel.text = error
        case 3:
            self.confirmPasswordErrorLabel.isHidden = false
            self.confirmPasswordErrorLabel.text = error
            
        default:
            hideErrorLabels()
        }
    }
    
    func goTohome() {
        
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideErrorLabels()
    }
}
