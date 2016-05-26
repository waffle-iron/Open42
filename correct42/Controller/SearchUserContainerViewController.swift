//
//  SearchUserContainerViewController.swift
//  correct42
//
//  Created by larry on 02/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class SearchUserContainerViewController: UIViewController {

	// MARK: - Singletons
	/// Singleton of `UserManger`
	let userManager = UserManager.Shared()
	
	// MARK: - View life cycle
	/// Set `self.title` to Default value
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.title = "Unknown"
	}
	
	/// Fill `self.title` with the login of the `self.userManager.currentUser`
	override func viewDidAppear(animated: Bool) {
		if let currentUser = self.userManager.currentUser {
			self.title = currentUser.login
		}
	}
}
