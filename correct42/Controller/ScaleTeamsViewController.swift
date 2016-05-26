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
		if let scaleTeamCellPrototype:ScaleTeamTableViewCell? = {
			let scaleTeamCell = self.scaleTeamsTable.dequeueReusableCellWithIdentifier(self.cellName)
			if scaleTeamCell is ScaleTeamTableViewCell{
				return (scaleTeamCell as! ScaleTeamTableViewCell)
			}
			return (nil)
		}(){
		
			let curScaleTeam = scaleTeamsManager.list[indexPath.row]
			scaleTeamCellPrototype?.setText(curScaleTeam.beginAt,projectName: curScaleTeam.scale.name)
			return (scaleTeamCellPrototype)!
		}
		return (UITableViewCell())
	}
	
	/**
	Define the height of a cell `cellName`. Constant = 100
	*/
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return (100)
	}
	
	/**
	Format and Add entry to the calendar with `addEventToCalendar` helper.
	*/
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let curScaleTeam = scaleTeamsManager.list[indexPath.row]
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR")
		dateFormatter.dateFormat = "yyyy-LL-dd'T'HH:mm:ss'.'SSSz"
		if let startDate = dateFormatter.dateFromString(curScaleTeam.beginAt){
			addEventToCalendar(title: curScaleTeam.scale.name, description: "", startDate: startDate, endDate: startDate.dateByAddingTimeInterval(1/4 * 60 * 60), onCompletion: { (success, error) in
				print("Date added ! success ? \(success)")
				if (!success){
					showAlertWithTitle("Corrections", message: "Oups ! A problem occured.", view: self)
				} else {
					showAlertWithTitle("Corrections", message: "Your correction slot on \(curScaleTeam.scale.name) has been added to your calendar at \(startDate)", view: self)
				}
			})
		} else {
			print("Date formatting fail...")
		}
	}
}
