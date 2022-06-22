//
//  ViewController.swift
//  Anthill
//
//  Created by 장재훈 on 2022/06/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTappedAuthButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: SignInViewController.storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SignInViewController.identifier) as! SignInViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

