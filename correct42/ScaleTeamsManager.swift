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
				self.list.append(ScaleTeam(jsonFetch: scaleInfos))
			}
			success(self.list)
		}) { (error) in
			// get local requester if exist else
			failure(error)
		}
	}
}