//
//  ViewController.swift
//  correct42
//
//  Created by larry on 16/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

	let apiRequester = APIRequester.Shared()
	
	@IBOutlet weak var LoginLoading: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		
	}
	
	@IBAction func connect42(sender: UIButton) {
		LoginLoading.startAnimating()
		apiRequester.connectApi(self, success: { () in
				self.performSegueWithIdentifier("connectSegue", sender: self)
				self.LoginLoading.stopAnimating()
			}) { (error) in
				print("Error code : \(error.code)")
				self.LoginLoading.stopAnimating()
			}
	}
	

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

