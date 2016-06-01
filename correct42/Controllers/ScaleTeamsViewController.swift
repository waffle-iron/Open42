//
//  ScaleTeamsViewController.swift
//  correct42
//
//  Created by larry on 15/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import EventKit

class ScaleTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	// MARK: - IBOutlets
	/// Table view of each scaleTeams of token owner
	@IBOutlet weak var scaleTeamsTable: UITableView!
	
	// MARK: - Proprieties
	/// Name of the custom cell call by the `scaleTeamsTable`
	var cellName = "ScaleTeamCell"

	// MARK: - Singletons
	/// Singleton of `ScaleTeamsManager`
	let scaleTeamsManager = ScaleTeamsManager.Shared()
	/// Singleton of `UserManager`
	let userManager = UserManager.Shared()
	
	// MARK: - View life cycle
	/**
	Fetch user data from api with `scaleTeamsManager` and Register Custom cells, fill delegate and dataSource `scaleTeamsTable` by `ScaleTeamsViewController`
	*/
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
	
	// MARK: - IBActions
	@IBAction func addToCalendarAction(sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Corrections", message: "Do you want to add Scale teams to your calendar ?", preferredStyle: .ActionSheet)
		alert.addAction(UIAlertAction(title: "Do it !", style: .Default, handler: { (alertAction) in
			self.addScaleTeamsToCalendar()
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}

	// MARK: - TableView delegation
	/**
	Count `scaleTeamsManager.list` for the `scaleTeamsTable` numberOfRowsInSection.
	*/
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (scaleTeamsManager.list.count)
	}
	
	/**
	Create a `ScaleTeamTableViewCell` and fill it.
	- Returns: An `ScaleTeamTableViewCell` filled.
	*/
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return (createScaleCell(indexPath.row))
	}
	
	/**
	Define the height of a cell `cellName`. Constant = 100
	*/
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return (93)
	}
	
	/**
	Format and Add entry to the calendar with `addEventToCalendar` helper.
	*/
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let curScaleTeam = scaleTeamsManager.list[indexPath.row]
		// If corrector visible (maybe it's you)
		if let corrector = curScaleTeam.corrector {
			if corrector.id == userManager.loginUser?.id {
				// If the login user are the corrector
				// If corrected is visible
				if let corrected = curScaleTeam.correcteds.first {
					// Go to profil user corrected
					userManager.fetchUserById(corrected.id, success: { (user) in
							self.userManager.currentUser = user
							self.userManager.correctionUser = user
							self.performSegueWithIdentifier("goToScaleUser", sender: self)
						}, failure: { (error) in
							showAlertWithTitle("Corrections", message: "Un problème est survenu, l'utilisateur ne semble plus exister.", view: self)
					})
				}
			} else {
				// if you're corrected and the corrector are visible
				// Go to profil corrector
				userManager.fetchUserById(corrector.id, success: { (user) in
						self.userManager.currentUser = user
						self.userManager.correctionUser = user
						self.performSegueWithIdentifier("goToScaleUser", sender: self)
					}, failure: { (error) in
						showAlertWithTitle("Corrections", message: "Un problème est survenu, l'utilisateur ne semble plus exister.", view: self)
				})
			}
		}
	}
	
	// MARK: - Private methods
	/// Create Scale cell by indexPath.row
	func createScaleCell(indexPathRow:Int) -> UITableViewCell {
		if let scaleTeamCellPrototype:ScaleTeamTableViewCell? = {
			let scaleTeamCell = self.scaleTeamsTable.dequeueReusableCellWithIdentifier(self.cellName)
			if scaleTeamCell is ScaleTeamTableViewCell{
				return (scaleTeamCell as! ScaleTeamTableViewCell)
			}
			return (nil)
			}(){
			
			let curScaleTeam = scaleTeamsManager.list[indexPathRow]
			// If corrector visible (maybe it's you)
			if let corrector = curScaleTeam.corrector {
				if corrector.id == userManager.loginUser?.id {
					// If it's the owner token
					// If corrected is visible
					if let corrected = curScaleTeam.correcteds.first {
						scaleTeamCellPrototype?.setText(false, correctedLogin:corrected.login, date:curScaleTeam.beginAt, projectName:curScaleTeam.scale.name)
					} else {
						// If corrected is invisible
						scaleTeamCellPrototype?.setText(false, correctedLogin:nil, date:curScaleTeam.beginAt, projectName:curScaleTeam.scale.name)
					}
				} else {
					// if you're not the corrector and the corrector are visible
					scaleTeamCellPrototype?.setText(true, correctedLogin: corrector.login, date:curScaleTeam.beginAt, projectName:curScaleTeam.scale.name)
				}
			} else {
				// if corrector is not visible (not you for sure)
				scaleTeamCellPrototype?.setText(true, correctedLogin:nil, date:curScaleTeam.beginAt, projectName:curScaleTeam.scale.name)
			}
			return (scaleTeamCellPrototype)!
		}
		return (UITableViewCell())
	}
	
	private func addScaleTeamsToCalendar(){
		var i = 0
		for curScaleTeam in scaleTeamsManager.list {
			if (!scaleTeamsManager.alreadyInCalendar(curScaleTeam)){
				scaleTeamsManager.addedToCalendar(curScaleTeam, onCompletion: { (success, error) in
					if (!success){
						showAlertWithTitle("Corrections", message: error!.userInfo.indexForKey(0).debugDescription, view: self)
					}
				})
				i = i + 1
			}
		}
		if (i == 0){
			showAlertWithTitle("Corrections", message: "All scale Teams are already added.", view: self)
		} else {
			showAlertWithTitle("Corrections", message: "Vos corrections ont été ajouté.", view: self)
		}
	}
}
