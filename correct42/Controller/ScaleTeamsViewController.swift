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
			scaleTeamCellPrototype?.setText(curScaleTeam.beginAt,projectName: curScaleTeam.scale.name)
			return (scaleTeamCellPrototype)!
		}
		return (UITableViewCell())
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return (100)
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let curScaleTeam = scaleTeamsManager.list[indexPath.row]
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR")
		dateFormatter.dateFormat = "yyyy-LL-dd'T'HH:mm:ss'.'SSSz"
		if let startDate = dateFormatter.dateFromString(curScaleTeam.beginAt){
			addEventToCalendar(title: curScaleTeam.scale.name, description: "", startDate: startDate, endDate: startDate.dateByAddingTimeInterval(1/4 * 60 * 60), completion: { (success, error) in
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
	
	private func addEventToCalendar(title title: String, description: String?, startDate: NSDate, endDate: NSDate, completion: ((success: Bool, error: NSError?) -> Void)? = nil) {
		let eventStore = EKEventStore()
		
		eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) in
			if (granted) && (error == nil) {
				let event = EKEvent(eventStore: eventStore)
				event.title = title
				event.startDate = startDate
				event.endDate = endDate
				event.notes = description
				event.calendar = eventStore.defaultCalendarForNewEvents
				do {
					try eventStore.saveEvent(event, span: .ThisEvent)
				} catch let e as NSError {
					completion?(success: false, error: e)
					return
				}
				completion?(success: true, error: nil)
			} else {
				completion?(success: false, error: error)
			}
		})
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
