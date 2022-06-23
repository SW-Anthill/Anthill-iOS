//
//  AuthModel.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import Foundation
import UIKit

struct RootInfo {
    static func currentUserExists() -> Bool {
        if UserDefaults.standard.string(forKey: "userId") == nil {
            return false
        }
        return true
    }

    static func rootToHomeView() -> HomeViewController {
        let mainStoryboard = UIStoryboard(name: HomeViewController.storyboard, bundle: nil)
        let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController

        return protectedPage
    }

    static func rootToSignInView() -> SignInViewController {
        let mainStoryboard = UIStoryboard(name: SignInViewController.storyboard, bundle: nil)
        let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: SignInViewController.identifier) as! SignInViewController

        return protectedPage
    }
}

struct ValidResponse: Codable {
    var message: String

    func getResultFromMessage() -> Bool {
        return message == "true" ? true : false
    }
}

struct UserInfo: Codable {
    var userId: String
    var nickname: String
    var name: String
    var phone: String
    var address: UserAddress

    enum CodingKeys: String, CodingKey {
        case userId
        case nickname = "nickName"
        case name
        case phone = "phoneNumber"
        case address
    }
}

struct UserAddress: Codable {
    var zipCode: String
    var address1: String
    var address2: String
}
