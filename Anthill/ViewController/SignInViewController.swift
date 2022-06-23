//
//  SignInViewController.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import Alamofire
import UIKit

class SignInViewController: UIViewController {
    static let identifier = "SignInViewController"
    static let storyboard = "AuthView"

    @IBOutlet var idField: UITextField!
    @IBOutlet var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - IBActions

extension SignInViewController {
    @IBAction func onTappedSignInButton(_ sender: Any) {
        if validateField() {
            trySignIn()
        } else {
            failureAlert()
        }
    }

    @IBAction func onTappedSignUpButton(_ sender: Any) {
        // navigate to SignUpView

        let storyboard = UIStoryboard(name: SignUpViewController.storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SignUpViewController.identifier) as! SignUpViewController
        vc.title = "회원가입"

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInViewController {
    private func validateField() -> Bool {
        guard let id = idField.text else {
            return false
        }

        guard let password = passwordField.text else {
            return false
        }

        return !id.isEmpty && !password.isEmpty
    }

    private func failureAlert() {
        let sheet = UIAlertController(title: "로그인 실패", message: "로그인에 실패하였습니다. 아이디와 비밀번호를 다시 한번 확인해주세요.", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "확인", style: .default))

        present(sheet, animated: true)
    }

    private func trySignIn() {
        let params = [
            "userId": idField.text,
            "password": passwordField.text,
        ]

        AF.request(
            Server.url + "members",
            method: .post,
            parameters: params as Parameters,
            encoding: JSONEncoding.default
        )
        .response { response in
            if let error = response.error {
                print(">> 로그인 Error : \(error)")
                return
            }
            
            if response.response?.statusCode == 200 {
                // 로그인 완료
            }
        }
    }
}
