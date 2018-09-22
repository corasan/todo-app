//
//  SecondViewController.swift
//  TodoApp
//
//  Created by Henry Paulino on 9/19/18.
//  Copyright © 2018 Henry Paulino. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	@IBAction func logoutBtn(_ sender: Any) {
		do {
			try Auth.auth().signOut()
			navigateToLogin()
		} catch let signOutError as NSError {
			print("Error signing out: %@", signOutError)
		}
	}
	
	private func navigateToLogin() {
		let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let authNavigation = mainStoryBoard.instantiateViewController(withIdentifier: "LoginView") as UIViewController
		
		present(authNavigation, animated: true, completion: nil)
	}
}

