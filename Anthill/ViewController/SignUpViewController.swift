//
//  SignUpViewController.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import UIKit

class SignUpViewController: UIViewController {
    static let identifier = "SignUpViewController"
    static let storyboard = "AuthView"
    
    // Labels
    @IBOutlet weak var validIdLabel: UILabel!
    @IBOutlet weak var validNicknameLabel: UILabel!
    @IBOutlet weak var validPhoneLabel: UILabel!

    // TextFields
    @IBOutlet var idField: UITextField!
    @IBOutlet var nicknameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var mainAddressField: UITextField!
    @IBOutlet var detailAddressField: UITextField!
    
    // Buttons
    @IBOutlet weak var validIdButton: UIButton!
    @IBOutlet weak var validNicknameButton: UIButton!
    @IBOutlet weak var validPhoneButton: UIButton!
    
    @IBOutlet weak var findAddressButton: UIButton!
    @IBOutlet weak var signUpDoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - IBActions

extension SignUpViewController {
    @IBAction func onTappedValidIdButton(_ sender: Any) {
    }
    
    @IBAction func onTappedValidNicknameButton(_ sender: Any) {
    }
    
    @IBAction func onTappedValidPhoneButton(_ sender: Any) {
    }
    
    @IBAction func onTappedFindAddressButton(_ sender: Any) {
    }
    
    @IBAction func onTappedSignUpDoneButton(_ sender: Any) {
    }
}


// MARK: - API Requests

extension SignUpViewController {
    private func validId() {
        
    }
    
    private func validNickname() {
        
    }
    
    private func validPhone() {
        
    }
    
    private func signUpDone() {
        
    }
}
