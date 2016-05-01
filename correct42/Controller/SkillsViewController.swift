//
//  SkillsViewController.swift
//  correct42
//
//  Created by larry on 01/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

	@IBOutlet weak var skillTable: UITableView!
	@IBOutlet weak var titleLabel: UILabel!
	
	
	//MARK: - Needed
	let userManager = UserManager.Shared().currentUser
	let cellName = "skillCell"
	
	lazy var skills:[Skill] = {
		if let cursusSkills = self.userManager?.cursus.first?.skills{
			return (cursusSkills.sort({ $0.level > $1.level }))
		}
		return ([])
	}()
	
	@IBAction func clickBackButton(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		//Register skill cell
		let nib = UINib(nibName: cellName, bundle: nil)
		skillTable.registerNib(nib, forCellReuseIdentifier: cellName)
		skillTable.delegate = self
		skillTable.dataSource = self
	}
	
	override func viewWillAppear(animated: Bool) {
		if let currentUser = userManager{
			titleLabel.text = "\(currentUser.login)'s skills"
		}
	}
	
	@IBAction func SortBy(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			skills = skills.sort({ $0.name < $1.name })
			break
		case 1:
			skills = skills.sort({ $0.level > $1.level })
			break
		case 2:
			skills = skills.sort({ $0.name > $1.name })
			break
		default:
			break
		}
		skillTable.reloadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (skills.count)
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let skillCellPrototype:SkillTableViewCell? = {
			let skillCell = self.skillTable.dequeueReusableCellWithIdentifier(self.cellName)
			if skillCell is SkillTableViewCell{
				return (skillCell as! SkillTableViewCell)
			}
			return (nil)
		}()
		
		skillCellPrototype!.levelLabel.text = "\(skills[indexPath.row].level)"
		skillCellPrototype!.skillNameLabel.text = skills[indexPath.row].name
		
		return (skillCellPrototype!)
	}
}
