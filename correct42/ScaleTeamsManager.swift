//
//  ScaleTeamsManager.swift
//  correct42
//
//  Created by larry on 15/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Foundation

class ScaleTeamsManager {
	// MARK: - Singleton
	static let sharedInstance = ScaleTeamsManager()
	
	static func Shared() -> ScaleTeamsManager
	{
		return (self.sharedInstance)
	}
	
	// MARK: - Proprieties
	lazy var list:[ScaleTeam] = [ScaleTeam]()
	
	// MARK: - Services
	let apiRequester = ApiRequester.Shared()

	// MARK: - Methods
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