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
