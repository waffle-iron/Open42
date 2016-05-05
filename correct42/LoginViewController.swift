//
//  ViewController.swift
//  correct42
//
//  Created by larry on 16/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate{

	let apiRequester = ApiRequester.Shared()
	var isConnected = false
	
	@IBOutlet weak var LoginLoading: UIActivityIndicatorView!
	
	@IBAction func connect42(sender: UIButton) {
		LoginLoading.startAnimating()
		apiRequester.connectApi(self, delegateSafari: self, success: { () in
				self.isConnected = true
			}) { (error) in
				print("Error code : \(error.code)")
			}
	}
	
	override func viewDidAppear(animated: Bool) {
		connect()
	}
	
	override func viewDidLoad() {
	}
	
	func connect(){
		if (isConnected){
			self.LoginLoading.startAnimating()
			self.performSegueWithIdentifier("connectSegue", sender: self)
			self.LoginLoading.stopAnimating()
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func safariViewControllerDidFinish(controller: SFSafariViewController) {
		self.LoginLoading.stopAnimating()
	}
}

