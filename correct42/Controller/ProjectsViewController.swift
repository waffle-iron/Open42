//
//  ProjectsViewController.swift
//  correct42
//
//  Created by larry on 01/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	//MARK: - UIView Links
	@IBOutlet weak var projectTable: UITableView!
	@IBOutlet weak var titleLabel: UILabel!
	
	//MARK: - Needed
	let userManager = UserManager.Shared().currentUser
	let cellName = "projectCell"
	
	lazy var projects:[Project] = {
		if let cursusProjects = self.userManager?.cursus.first?.projects{
			return (cursusProjects.sort({ $0.finalMark > $1.finalMark }))
		}
		return ([])
	}()
	
	@IBAction func clickBackButton(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		//Register project cell
		let nib = UINib(nibName: cellName, bundle: nil)
		projectTable.registerNib(nib, forCellReuseIdentifier: cellName)
		projectTable.delegate = self
		projectTable.dataSource = self
    }
	
	override func viewWillAppear(animated: Bool) {
		if let currentUser = userManager{
			titleLabel.text = "\(currentUser.login)'s projects"
		}
	}
	
	@IBAction func SortBy(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			projects = projects.sort({ $0.slug < $1.slug })
			break
		case 1:
			projects = projects.sort({ $0.finalMark > $1.finalMark })
			break
		case 2:
			projects = projects.sort({ $0.slug > $1.slug })
			break
		default:
			break
		}
		projectTable.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (projects.count)
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let projectCellPrototype:ProjectTableViewCell? = {
			let projectCell = self.projectTable.dequeueReusableCellWithIdentifier(self.cellName)
			if projectCell is ProjectTableViewCell{
				return (projectCell as! ProjectTableViewCell)
			}
			return (nil)
		}()
		projectCellPrototype!.markLabel.text = "\(projects[indexPath.row].finalMark) %"
		
		if (projects[indexPath.row].finalMark >= 50){
			projectCellPrototype!.markLabel.textColor = UIColor.greenDarkColor()
		} else {
			projectCellPrototype!.markLabel.textColor = UIColor.redDarkColor()
		}
		projectCellPrototype!.projectNameLabel.text = projects[indexPath.row].slug.stringByReplacingOccurrencesOfString("-", withString: " ", options: NSStringCompareOptions.LiteralSearch, range: nil).capitalizedString
			return (projectCellPrototype!)
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

private extension UIColor {
	static func greenDarkColor() -> UIColor{
		return (UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0))
	}
	
	static func redDarkColor() -> UIColor{
		return (UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0))
	}
}