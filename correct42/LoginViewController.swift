//
//  ViewController.swift
//  correct42
//
//  Created by larry on 16/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate, SearchManagerDelegation{

	let apiRequester = ApiRequester.Shared()
	let userManager = UserManager.Shared()
	let searchManager = SearchManager.Shared()
	var isConnected = false
	
	@IBOutlet weak var progressBarLogin: UIProgressView!
	@IBOutlet weak var LoginLoading: UIActivityIndicatorView!
	@IBOutlet weak var loadingInformationsLabel: UILabel!

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
	@IBOutlet weak var button42Login: UIButton!
	
	@IBAction func connect42(sender: UIButton) {
		LoginLoading.startAnimating()
		apiRequester.connectApi(self, delegateSafari: self, success: { () in
				self.isConnected = true
			}) { (error) in
				print("Error code : \(error.code)")
			}
	}
	
	override func viewDidLoad() {
		searchManager.delegate = self
		progressBarLogin.hidden = true
	}
	
	override func viewDidAppear(animated: Bool) {
		progressBarLogin.progress = 0.0
		connect()
	}
	
	func connect(){
		dispatch_async(dispatch_get_main_queue()){
			if (self.isConnected){
				self.button42Login.hidden = true
				self.loadingInformationsLabel.text = "loading..."
				self.isConnected = false
                self.fetchUser()
			} else {
				self.progressBarLogin.hidden = true
				self.LoginLoading.stopAnimating()
			}
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func safariViewControllerDidFinish(controller: SFSafariViewController) {
		self.LoginLoading.stopAnimating()
	}
	
	func fetchUser(){
		self.LoginLoading.startAnimating()
		self.loadingInformationsLabel.text = "Loading profile..."
		self.userManager.fetchMyProfil({ (user) in
			self.userManager.loginUser = user
			self.userManager.currentUser = user
			self.fetchListUser()
		}) { (error) in
			print(error.domain)
		}
	}
	
	func fetchListUser() { // ~2 min 30.
		// Start loading user for search
		self.progressBarLogin.hidden = false
		self.loadingInformationsLabel.text = "Loading users list for research more faster than ever...\n(Only happens once a year)"
		if !searchManager.fileAlreadyExist() {
			searchManager.fetchUsersOnAPI(0) { (success, error) in
				if (success){
					self.performSegueWithIdentifier("connectSegue", sender: self)
				} else {
					showAlertWithTitle("Loading users list", message: "A problem occured.", view: self)
				}
				self.LoginLoading.stopAnimating()
				self.button42Login.hidden = false
				self.progressBarLogin.hidden = true
			}
		} else {
			progressBarLogin.progress = 1
			searchManager.fetchUsersOnFile({ (success, error) in
				if (success){
					self.performSegueWithIdentifier("connectSegue", sender: self)
				} else {
					showAlertWithTitle("Loading users list", message: "A problem occured.", view: self)
				}
				self.LoginLoading.stopAnimating()
				self.button42Login.hidden = false
				self.progressBarLogin.hidden = true
			})
		}
	}
	
	func searchManager(percentOfCompletion percent: Int) {
		let percentFloat = Float(percent)/100
		progressBarLogin.progress = percentFloat
	}
}

