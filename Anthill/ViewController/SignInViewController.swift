//
//  SignInViewController.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import UIKit

class SignInViewController: UIViewController {
    static let identifier = "SignInViewController"
    static let storyboard = "AuthView"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IBActions

extension SignInViewController {
    @IBAction func onTappedSignInButton(_ sender: Any) {
    }

    @IBAction func onTappedSignUpButton(_ sender: Any) {
        // navigate to SignUpView
        
        let storyboard = UIStoryboard(name: SignUpViewController.storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SignUpViewController.identifier) as! SignUpViewController
        vc.title = "회원가입"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
