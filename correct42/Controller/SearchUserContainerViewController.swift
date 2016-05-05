//
//  SearchUserContainerViewController.swift
//  correct42
//
//  Created by larry on 02/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class SearchUserContainerViewController: UIViewController {

	let userManager = UserManager.Shared()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.title = "user profile"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func backButton(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	override func viewDidAppear(animated: Bool) {
		self.userManager.currentUser = self.userManager.searchUser
		self.title = self.userManager.searchUser?.login
		NSNotificationCenter.defaultCenter().postNotificationName(reloadUserNotifKey, object: self)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
