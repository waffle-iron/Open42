
//
//  achievement.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Achievement: SuperModel, IdDelegate {
	lazy var id:Int  = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var description:String = {
		return (self.jsonData["description"].stringValue)
	}()
	
	lazy var tier:String = {
		return (self.jsonData["tier"].stringValue)
	}()
	
	lazy var kind:String = {
		return (self.jsonData["kind"].stringValue)
	}()
	
	lazy var visible:Bool = {
		return (self.jsonData["visible"].boolValue)
	}()
	
	lazy var image:String = {
		return (self.jsonData["image"].stringValue)
	}()
	
	lazy var nbrOfSuccess:Int = {
		return (self.jsonData["nbr_of_success"].intValue)
	}()
	
	lazy var usersUrl:String = {
		return (self.jsonData["users_url"].stringValue)
	}()
	
	
	lazy var achievements:[Achievement] = {
		var achievementsGet = [Achievement]()
		for achievement in self.jsonData["achievements"].arrayValue {
			achievementsGet.append(Achievement(jsonFetch: achievement))
		}
		return (achievementsGet)
	}()
	
	lazy var parent:Achievement = {
		return (Achievement(jsonFetch: self.jsonData["parent"]))
	}()
	
	lazy var title:Title = {
		return (Title(jsonFetch: self.jsonData["title"]))
	}()

}
