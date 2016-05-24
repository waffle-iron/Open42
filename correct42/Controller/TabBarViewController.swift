//
//  TabBarViewController.swift
//  correct42
//
//  Created by larry on 19/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{

	let userManager = UserManager.Shared()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.userManager.currentUser = self.userManager.loginUser
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
		if let items = tabBar.items {
			switch item {
			case items[0]:
				self.userManager.currentUser = self.userManager.loginUser
				break
			case items[1]:
				self.userManager.currentUser = self.userManager.searchUser
				break
			case items[2]:
				self.userManager.currentUser = self.userManager.correctionUser
				break
			default:
				self.userManager.currentUser = self.userManager.loginUser
				break
			}
		}
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
