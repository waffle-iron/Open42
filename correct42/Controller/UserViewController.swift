//
//  UserViewController.swift
//  correct42
//
//  Created by larry on 30/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class UserViewController: UIViewController{

	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var pseudoLabel: UILabel!
	@IBOutlet weak var mobileLabel: UITextView!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var walletsLabel: UILabel!
	@IBOutlet weak var pointsLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	
	var user = UserManager.Shared()
	var apiRequester = ApiRequester.Shared()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		userImage.layer.cornerRadius = userImage.frame.size.width/2
		userImage.clipsToBounds = true
    }
	
	override func viewDidAppear(animated: Bool) {
		fillUser()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func fillUser(){
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
	
	private func fillImage(imageUrl:String){
		apiRequester.downloadImage(imageUrl, success: { (image) in
				self.userImage.image = image
			}, failure: { (error) in
				print(error.domain)
		})
	}
	
	@IBAction func ClickButtonProjects(sender: UIButton) {
		self.performSegueWithIdentifier("goToProjects", sender: self)
	}
	
	@IBAction func ClickButtonSkills(sender: UIButton) {
		self.performSegueWithIdentifier("goToSkills", sender: self)
	}
}
