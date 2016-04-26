//
//  ViewController.swift
//  correct42
//
//  Created by larry on 16/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	let apiRequester = APIRequester.Shared()
	
	override func viewDidLoad() {
		
	}
	
	@IBAction func connect42(sender: UIButton) {
		apiRequester.connectApi(self, success: { () in
				self.performSegueWithIdentifier("connectSegue", sender: self)
			}) { (error) in
				print("Error code : \(error.code)")
			}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

