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
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var firstNameLabel: UILabel!
    
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var lastNameErrorLabel: UILabel!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailErrorLabel: UILabel!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordErrorLabel: UILabel!

    @IBOutlet var confirmPasswordTextField: UITextField!
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
        self.firstNameTextField.placeholder = NSLocalizedString("register.first.name.placeholder", comment: "")
        self.lastNameTextField.placeholder = NSLocalizedString("register.last.name.placeholder", comment: "")
        self.emailTextField.placeholder = NSLocalizedString("register.email.address.placeholder", comment: "")
        self.passwordTextField.placeholder = NSLocalizedString("register.password.placeholder", comment: "")
        self.confirmPasswordTextField.placeholder = NSLocalizedString("register.confirm.password.placeholder", comment: "")
        self.registerButton.setTitle(NSLocalizedString("register.register.button.title", comment: ""), for: .normal)
    }
    
    private func setupCornerRadius() {
        self.firstNameTextField.layer.cornerRadius = 25.0
        self.lastNameTextField.layer.cornerRadius = 25.0
        self.emailTextField.layer.cornerRadius = 25.0
        self.passwordTextField.layer.cornerRadius = 25.0
        self.confirmPasswordTextField.layer.cornerRadius = 25.0
        self.registerButton.layer.cornerRadius = 25.0
    }
    
    private func hideErrorLabels() {
        self.firstNameLabel.isHidden = true
        self.lastNameErrorLabel.isHidden = true
        self.emailErrorLabel.isHidden = true
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
        if interactor.shouldRegister(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "") {
            interactor.performRegister(name: emailTextField.text ?? "", password: passwordTextField.text ?? "")
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
            self.firstNameLabel.isHidden = false
            self.firstNameLabel.text = error
        case 2:
            self.lastNameErrorLabel.isHidden = false
            self.lastNameErrorLabel.text = error
        case 3:
            self.emailTextField.isHidden = false
            self.emailTextField.text = error
        case 4:
            self.passwordErrorLabel.isHidden = false
            self.passwordErrorLabel.text = error
        case 5:
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
