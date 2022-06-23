//
//  HomeViewController.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/23.
//

import Alamofire
import UIKit

class HomeViewController: UIViewController {
    static let identifier = "HomeViewController"
    static let storyboard = "HomeView"

    var userDefaultsUserId: String?

    @IBOutlet var userDefaultsLabel: UILabel!

    @IBOutlet var userIdLabel: UILabel!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        userDefaultsUserId = UserDefaults.standard.string(forKey: "userId")
        userDefaultsLabel.text = "기기 저장 userId : " + (userDefaultsUserId ?? "not found")
    }

    @IBAction func onTappedFetchUserInfo(_ sender: Any) {
        guard let userId = userDefaultsUserId else {
            let sheet = UIAlertController(title: "오류발생", message: "잘못된 회원정보 입니다. 로그아웃을 시도합니다.", preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                self.trySignOut()
            }))
            return
        }

        AF.request(Server.url + "members/" + userId, method: .get)
            .response { response in
                if let error = response.error {
                    print(">> 회원정보 get Error : \(error)")
                    return
                }
                
                print(response.response?.statusCode)

                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(UserInfo.self, from: response.data!)

                    self.userIdLabel.text = data.userId
                    self.nickNameLabel.text = data.nickname
                    self.nameLabel.text = data.name
                    self.phoneNumberLabel.text = data.phone
                    self.addressLabel.text = "\(data.address.address1) \(data.address.zipCode) \(data.address.address2)"

                } catch let decodeError {
                    print(">> 회원정보 decode Error: \(decodeError)")
                }
            }
    }

    @IBAction func onTappedSignOut(_ sender: Any) {
        let sheet = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "아니오", style: .default))
        sheet.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            self.trySignOut()
        }))
        
        present(sheet, animated: true)
    }

    private func trySignOut() {
        UserDefaults.standard.set(nil, forKey: "userId")

        let window = view.window
        let protectedPage = RootInfo.rootToSignInView()
        let rootViewController = UINavigationController(rootViewController: protectedPage)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
