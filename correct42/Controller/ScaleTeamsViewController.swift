//
//  ScaleTeamsViewController.swift
//  correct42
//
//  Created by larry on 15/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class ScaleTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	// MARK: - Proprieties
	@IBOutlet weak var scaleTeamsTable: UITableView!
	var cellName = "ScaleTeamCell"

	// MARK: - Services
	let scaleTeamsManager = ScaleTeamsManager.Shared()
	let userManager = UserManager.Shared()
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		scaleTeamsManager.fetchMyScaleTeams({ (_) in
			self.scaleTeamsTable.reloadData()
		}){ (error) in
			print("Error on load")
		}
		
		//delegation
		let nib = UINib(nibName: cellName, bundle: nil)
		scaleTeamsTable.registerNib(nib, forCellReuseIdentifier: cellName)
		scaleTeamsTable.delegate = self
		scaleTeamsTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (scaleTeamsManager.list.count)
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if let scaleTeamCellPrototype:ScaleTeamTableViewCell? = {
			let scaleTeamCell = self.scaleTeamsTable.dequeueReusableCellWithIdentifier(self.cellName)
			if scaleTeamCell is ScaleTeamTableViewCell{
				return (scaleTeamCell as! ScaleTeamTableViewCell)
			}
			return (nil)
			}(){
		
		let curScaleTeam = scaleTeamsManager.list[indexPath.row]
		var firstCorrectedName = "someone"
		if (curScaleTeam.correcteds.count > 0){
			firstCorrectedName = curScaleTeam.correcteds[0].login
		}
		
		//TODO beware of bool : it can be wrong if you are the corrector.
		scaleTeamCellPrototype?.setText(
			Bool(curScaleTeam.correcteds.filter{$0.id == userManager.loginUser?.id}.count),
			correctedLogin: firstCorrectedName,
			date: curScaleTeam.beginAt,
			projectName: curScaleTeam.scale.name
		)
		return (scaleTeamCellPrototype)!
		}
		return (UITableViewCell())
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return (100)
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		//TODO click on cell send to user profil
		let curScaleTeam = scaleTeamsManager.list[indexPath.row]
		if (curScaleTeam.corrector?.id) != nil  {
			userManager.fetchUserById((curScaleTeam.corrector?.id)!, success: { (user) in
			self.userManager.correctionUser = user
			self.performSegueWithIdentifier("goToUserCorrect", sender: self)
			}) { (error) in
				print(error.domain)
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
