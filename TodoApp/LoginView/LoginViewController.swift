//
//  LoginViewController.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	@IBOutlet weak var email: UITextField!
	@IBOutlet weak var password: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	@IBAction func loginBtn(_ sender: Any) {
		let email = self.email.text!
		let password = self.password.text!
		
		login(email, password)
	}

	func login(_ email: String, _ password: String) {
		if (email != "" && password != "") {
			// something
		} else {
			showAlert(message: "Email and password fields cannot be empty.")
		}
	}
	
	private func showAlert(message: String) {
		let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		
		self.present(alert, animated: true)
	}
}
