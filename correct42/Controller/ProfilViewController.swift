//
//  ProfilViewController.swift
//  correct42
//
//  Created by larry on 30/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {

	@IBOutlet weak var userContainer: UIView!
	
	var userManager = UserManager.Shared()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		fetchUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func fetchUser(){
		userManager.fetchMyProfil({ (user) in
			self.userManager.currentUser = user
			NSNotificationCenter.defaultCenter().postNotificationName(reloadUserNotifKey, object: self)
			}) { (error) in
				print(error.domain)
		}
	}
}
