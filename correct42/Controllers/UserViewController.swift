//
//  UserViewController.swift
//  correct42
//
//  Created by larry on 30/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class UserViewController: UIViewController{

	// MARK: - Singletons
	/// Singleton of `UserManager`
	var user = UserManager.Shared()
	/// Singleton of `ApiRequester`
	var apiRequester = ApiRequester.Shared()
	
	// MARK: - IBOutlets
	/// Image view of the `userManager.currentUser`.
	@IBOutlet weak var userImage: UIImageView!
	
	/// Login label of the `userManager.currentUser`.
	@IBOutlet weak var pseudoLabel: UILabel!
	
	/// Mobile TextView of the `userManager.currentUser`.
	@IBOutlet weak var mobileLabel: UITextView!
	
	/// Email label of the `userManager.currentUser`.
	@IBOutlet weak var emailLabel: UILabel!
	
	/// Level label of the `userManager.currentUser`.
	@IBOutlet weak var levelLabel: UILabel!
	
	/// Wallet label of the `userManager.currentUser`.
	@IBOutlet weak var walletsLabel: UILabel!
	
	/// Correction points label of the `userManager.currentUser`.
	@IBOutlet weak var pointsLabel: UILabel!
	
	/// Location in 42 School label of the `userManager.currentUser`.
	@IBOutlet weak var locationLabel: UILabel!
	
	// MARK: - IBActions
	/// Perform segue with id:  `goToProjects`.
	@IBAction func ClickButtonProjects(sender: UIButton) {
		self.performSegueWithIdentifier("goToProjects", sender: self)
	}
	
	/// Perform segue with id:  `goToSkills`.
	@IBAction func ClickButtonSkills(sender: UIButton) {
		self.performSegueWithIdentifier("goToSkills", sender: self)
	}
	
	@IBAction func clickOnLabel(sender: UITapGestureRecognizer) {
//		if sender.accessibilityElements![0] is UILabel{
//			//let label = sender.accessibilityElements![0] as! UILabel
//			print("Label")
//			//UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(label.text?.stringByReplacingOccurrencesOfString(" ", withString: ""))")!)
//		} else {
//			print("Error")
//		}
	}

	// MARK: - View life cycle
	/// Define cornerRadius of the image.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		userImage.layer.cornerRadius = userImage.frame.size.width/2
		userImage.clipsToBounds = true
    }
	
	/// Ask to fill information from `userManager.currentUser`.
	override func viewWillAppear(animated: Bool) {
		fillUser()
	}
	
	// MARK: - Private methods
	/**
	If Fill information from `userManager.currentUser` else if he's optionnal
	fill view with defaults values.
	*/
	private func fillUser(){
		if let currentUser = user.currentUser{
			fillImage(currentUser.imageUrl)
			pseudoLabel.text = currentUser.login
			emailLabel.text = currentUser.email
			mobileLabel.text = currentUser.phone
			walletsLabel.text = "\(currentUser.wallet) ₳"
			pointsLabel.text = "\(currentUser.correctionPoint)"
			if currentUser.location != "" {
				locationLabel.text = currentUser.location
			} else {
				locationLabel.text = "-"
			}
			if let cursus = currentUser.cursus.first{
				levelLabel.text = "\(cursus.level)%"
			}
		} else {
			userImage.image = nil
			pseudoLabel.text = "Unknown"
			emailLabel.text = "Unknown"
			mobileLabel.text = "Unknown"
			walletsLabel.text = "0 ₳"
			pointsLabel.text = "0"
			locationLabel.text = "-"
			levelLabel.text = "0%"
		}
	}
	
	/**
	Take an imageUrl and downloadImage with `apiRequester.downloadImage` 
	and fill `userImage` with result on success.
	*/
	private func fillImage(imageUrl:String){
		apiRequester.downloadImage(imageUrl, success: { (image) in
				self.userImage.image = image
			}, failure: { (error) in
				print(error.domain)
		})
	}
}
