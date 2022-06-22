//
//  SignUpViewController.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import Alamofire
import UIKit

class SignUpViewController: UIViewController {
    static let identifier = "SignUpViewController"
    static let storyboard = "AuthView"

    var isValidId = false
    var isValidNickname = false
    var isValidPhone = false
    var isValidPassword = false

    // Labels
    @IBOutlet var validIdLabel: UILabel!
    @IBOutlet var validNicknameLabel: UILabel!
    @IBOutlet var validPhoneLabel: UILabel!
    @IBOutlet var confirmPasswordLabel: UILabel!

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
    @IBOutlet var validIdButton: UIButton!
    @IBOutlet var validNicknameButton: UIButton!
    @IBOutlet var validPhoneButton: UIButton!

    @IBOutlet var findAddressButton: UIButton!
    @IBOutlet var signUpDoneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        addPasswordListener()
    }
}

// MARK: - IBActions

extension SignUpViewController {
    @IBAction func onTappedValidIdButton(_ sender: Any) {
        validId()
    }

    @IBAction func onTappedValidNicknameButton(_ sender: Any) {
        validNickname()
    }

    @IBAction func onTappedValidPhoneButton(_ sender: Any) {
        validPhone()
    }

    @IBAction func onTappedFindAddressButton(_ sender: Any) {
    }

    @IBAction func onTappedSignUpDoneButton(_ sender: Any) {
        print("tapped!!!!!!!!!!!!!")
        if isAllValid() {
            trySignUp()
        } else {
            showSignUpDisabled()
        }
    }
}

// MARK: - API Requests

extension SignUpViewController {
    private func validId() {
        let id = idField.text!

        if idField.text == "" {
            validIdLabel.text = "아이디를 입력하세요"
            validIdLabel.textColor = .systemRed
            return
        }

        let url = Server.url + "user-id/" + id

        AF.request(url, method: .get)
            .response { response in
                if let error = response.error {
                    print(">> userID 중복체크 Error : \(error)")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ValidResponse.self, from: response.data!)
                    // true 중복, false 가능
                    let result = data.getResultFromMessage()

                    if result {
                        self.validIdLabel.text = "중복 아이디가 존재합니다"
                        self.validIdLabel.textColor = .systemRed
                    } else {
                        self.isValidId = true
                        self.validIdLabel.text = "사용 가능한 아이디입니다!"
                        self.validIdLabel.textColor = .systemGreen
                    }

                } catch let decodeError {
                    print(">> userID decode Error: \(decodeError)")
                }
            }
    }

    private func validNickname() {
        let nickname = nicknameField.text!

        if nicknameField.text == "" {
            validNicknameLabel.text = "닉네임을 입력하세요"
            validNicknameLabel.textColor = .systemRed
            return
        }

        let url = Server.url + "user-nickname/" + nickname

        AF.request(url, method: .get)
            .response { response in
                if let error = response.error {
                    print(">> nickname 중복체크 Error : \(error)")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ValidResponse.self, from: response.data!)
                    // true 중복, false 가능
                    let result = data.getResultFromMessage()

                    if result {
                        self.validNicknameLabel.text = "중복 닉네임이 존재합니다"
                        self.validNicknameLabel.textColor = .systemRed
                    } else {
                        self.isValidNickname = true
                        self.validNicknameLabel.text = "사용 가능한 닉네임입니다!"
                        self.validNicknameLabel.textColor = .systemGreen
                    }

                } catch let decodeError {
                    print(">> nickname decode Error: \(decodeError)")
                }
            }
    }

    private func validPhone() {
        let phone = phoneField.text!

        if phoneField.text == "" {
            validPhoneLabel.text = "닉네임을 입력하세요"
            validPhoneLabel.textColor = .systemRed
            return
        }

        let url = Server.url + "user-phonenumber/" + phone

        AF.request(url, method: .get)
            .response { response in
                if let error = response.error {
                    print(">> phone 중복체크 Error : \(error)")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(ValidResponse.self, from: response.data!)
                    // true 중복, false 가능
                    let result = data.getResultFromMessage()

                    if result {
                        self.validPhoneLabel.text = "동일한 전화번호가 존재합니다"
                        self.validPhoneLabel.textColor = .systemRed
                    } else {
                        self.isValidPhone = true
                        self.validPhoneLabel.text = "사용 가능한 번호입니다!"
                        self.validPhoneLabel.textColor = .systemGreen
                    }

                } catch let decodeError {
                    print(">> phone decode Error: \(decodeError)")
                }
            }
    }

    private func trySignUp() {
        let param: [String: Any] = [
            "userId": idField.text,
            "password": passwordField.text,
            "nickName": nicknameField.text,
            "name": userNameField.text,
            "phoneNumber": phoneField.text,
            "address": [
                "zipCode": "100-100",
                "address1": "경기도 시흥시",
                "address2": "XX아파트 XX호",
            ],
        ]

        AF.request(
            Server.url + "members",
            method: .post,
            parameters: param as Parameters,
            encoding: JSONEncoding.default
        )
        .response { response in
            if let error = response.error {
                print(">> 회원가입 Error : \(error)")
                return
            }

            print(response.response?.statusCode)

            if response.response?.statusCode == 201 {
                self.showSignUpDone()
            }
        }
    }
}

// MARK: - ETC

extension SignUpViewController {
    func isAllValid() -> Bool {
        let result = isValidId
            && isValidNickname
            && isValidPhone
            && isValidPassword
            && userNameField.text != ""

        return result
    }

    func showSignUpDisabled() {
        let sheet = UIAlertController(title: "실패", message: "입력 항목을 다시 한번 확인해주세요.", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "뒤로", style: .default))
        present(sheet, animated: true)
    }

    func showSignUpDone() {
        let sheet = UIAlertController(title: "성공", message: "회원가입에 성공하셨습니다! 로그인 페이지로 돌아가 로그인을 진행해주세요.", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(sheet, animated: true)
    }

    private func addPasswordListener() {
        confirmPasswordLabel.text = " "

        passwordField.addTarget(self, action: #selector(passwordFieldListener(_:)), for: .editingChanged)
        confirmPasswordField.addTarget(self, action: #selector(passwordFieldListener(_:)), for: .editingChanged)
    }

    @objc func passwordFieldListener(_ sender: Any?) {
        if passwordField.text != confirmPasswordField.text {
            confirmPasswordLabel.text = "비밀번호가 일치하지 않습니다"
            confirmPasswordLabel.textColor = .systemRed
        } else {
            if passwordField.text == "" {
                confirmPasswordLabel.text = "비밀번호를 입력하세요"
                confirmPasswordLabel.textColor = .systemRed
            } else {
                isValidPassword = true
                confirmPasswordLabel.text = "비밀번호 확인 완료"
                confirmPasswordLabel.textColor = .systemGreen
            }
        }
    }
}
