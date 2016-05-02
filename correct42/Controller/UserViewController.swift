//
//  UserViewController.swift
//  correct42
//
//  Created by larry on 30/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

let reloadUserNotifKey = "fr.spiroux-web.correct42.reloadUserNotifKey"

class UserViewController: UIViewController{

	@IBOutlet weak var userImage: UIImageView!
	@IBOutlet weak var pseudoLabel: UILabel!
	@IBOutlet weak var mobileLabel: UILabel!
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
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserViewController.fillUser), name: reloadUserNotifKey, object: nil)
		fillUser()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func fillUser(){
		fillImage()
		if let currentUser = user.currentUser{
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
		}
	}
	
	func fillImage(){
		if let currentUser = user.currentUser{
		apiRequester.downloadImage(currentUser.imageUrl, success: { (image) in
				self.userImage.image = image
			}, failure: { (error) in
				print(error.domain)
		})
		}
	}
	
	@IBAction func ClickButtonProjects(sender: UIButton) {
		self.performSegueWithIdentifier("goToProjects", sender: self)
	}
	
	@IBAction func ClickButtonSkills(sender: UIButton) {
		self.performSegueWithIdentifier("goToSkills", sender: self)
	}
	
	override func viewWillDisappear(animated: Bool) {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: reloadUserNotifKey, object: nil)
	}
}
