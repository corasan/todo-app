//
//  LoginViewController.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var loginBtn: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loginBtn.layer.cornerRadius = 6
		loginBtn.clipsToBounds = true
	}
	
	@IBAction func loginBtn(_ sender: Any) {
		let email = self.email.text!
		let password = self.password.text!
		
		login(email, password)
	}

	func login(_ email: String, _ password: String) {
		if (email != "" && password != "") {
			Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
				if let error = error {
					self.showAlert(message: "Error login in.")
					print("Error Message: \(error)")
					return
				}
				self.navigateToMainInterface()
			}
		} else {
			showAlert(message: "Email and password fields cannot be empty.")
		}
	}
	
	private func showAlert(message: String) {
		let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		
		self.present(alert, animated: true)
	}
	
	private func navigateToMainInterface() {
		let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
		guard let mainNavigation = mainStoryBoard.instantiateViewController(withIdentifier: "Main") as?
			UITabBarController else {
				return
		}
		
		present(mainNavigation, animated: true, completion: nil)
	}
}
