//
//  ScaleTeamsManager.swift
//  correct42
//
//  Created by larry on 15/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Foundation

class ScaleTeamsManager {
	// MARK: Singleton
	/// Static Instance of the ScaleTeamsManager
	static let sharedInstance = ScaleTeamsManager()
	
	
	/**
	Give the singleton object of the ScaleTeamsManager
	
	```
	let scaleTeamsManager = ScaleTeamsManager.Shared()
	```
	
	- returns: `static let instance`
	*/
	static func Shared() -> ScaleTeamsManager
	{
		return (self.sharedInstance)
	}
	
	// MARK: - Proprieties
	/// List of the scales team
	lazy var list:[ScaleTeam] = [ScaleTeam]()
	
	// MARK: - Services
	/// Singleton of the API
	let apiRequester = ApiRequester.Shared()
	/// Singleton of the user ersistent data
	let userPersistentData = NSUserDefaults.standardUserDefaults()

	// MARK: - Methods
	/**
	Fetch api Token by asking it to the user with webview his ids and execute
	corresponding callback.
	
	```
	let scaleTeamsManager = ScaleTeamsManager.Shared()
	ScaleTeamsManager.fetchMyScaleTeams(success:
	{ (listScaleTeam) in
		print("Success !")
	}
	}) { (error) in
		print(error)
	}
	```
	
	- Parameters:
		- success: CallBack execute if the request success and take a `ScaleTeam` array in parameter.
		- failure: CallBack execute if the request fail.
	*/
	func fetchMyScaleTeams(success:([ScaleTeam])->Void, failure:(NSError)->Void){
		apiRequester.request(ScaleTeamsRouter.Me, success: { (jsonData) in
			self.list.removeAll()
			for scaleInfos in jsonData.arrayValue {
				let scaleTeam = ScaleTeam(jsonFetch: scaleInfos)
				if (!self.idExist(scaleTeam.id)){
					self.list.append(scaleTeam)
				}
			}
			success(self.list)
		}) { (error) in
			// get local requester if exist else
			failure(error)
		}
	}
	
	/**
	Check in list of scaleTeam if an id exist
	
	- Parameters:
	- id: Id who we need to know if exist in the list of the scaleTeam.
	
	- Return: True if exist
	*/
	func idExist(id:Int) -> Bool {
		var result = false
		for scaleInfos in list{
			if (id == scaleInfos.id){
				result = true
			}
		}
		return (result)
	}
	
	func addedToCalendar(scaleTeam:ScaleTeam, onCompletion:(Bool, NSError?)->Void){
		let startDate = scaleTeam.beginAt
		let endDate = scaleTeam.beginAt.dateByAddingTimeInterval(Double(scaleTeam.scale.duration))
		addEventToCalendar(title: scaleTeam.scale.name, description: "", startDate: startDate, endDate: endDate, onCompletion: { (success, error) in
			if (!success){
				onCompletion(false, NSError(domain: "Corrections", code: -1, userInfo: [0:"Un probleme est survenu pendant l'ajout."]))
			} else {
				self.userPersistentData.setValue(startDate, forKey: "lastAddCalendarCorrection")
				onCompletion(true, nil)
			}
		})
	}
	
	func alreadyInCalendar(scaleTeam:ScaleTeam) -> Bool {
		if let lastAddedDate = userPersistentData.valueForKey("lastAddCalendarCorrection") {
			if (scaleTeam.beginAt <= lastAddedDate as? NSDate) {
				return (true)
			}
		}
		return (false)
	}
}