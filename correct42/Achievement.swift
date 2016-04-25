
//
//  achievement.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Achievement: SuperModel, IdDelegate {
	var id:Int {
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var description:String{
		get{ return (jsonData["description"].stringValue) }
		set{ jsonData["description"].string = newValue }
	}

	var tier:String{
		get{ return (jsonData["tier"].stringValue) }
		set{ jsonData["tier"].string = newValue }
	}

	var kind:String{
		get{ return (jsonData["kind"].stringValue) }
		set{ jsonData["kind"].string = newValue }
	}

	var visible:Bool{
		get{ return (jsonData["visible"].boolValue) }
		set{ jsonData["visible"].bool = newValue }
	}

	var image:String{
		get{ return (jsonData["image"].stringValue) }
		set{ jsonData["image"].string = newValue }
	}

	var nbrOfSuccess:Int{
		get{ return (jsonData["nbr_of_success"].intValue) }
		set{ jsonData["nbr_of_success"].int = newValue }
	}
	
	var usersUrl:String{
		get{ return (jsonData["users_url"].stringValue) }
		set{ jsonData["users_url"].string = newValue }
	}

	
	var achievements:[Achievement]{
		get {
			var achievementsGet = [Achievement]()
			for achievement in jsonData["achievements"].arrayValue {
				achievementsGet.append(Achievement(jsonFetch: achievement))
			}
			return (achievementsGet)
		}
	}

	var parent:Achievement{
		get{ return (Achievement(jsonFetch: jsonData["parent"])) }
	}
	
	var title:Title{
		get{ return (Title(jsonFetch: jsonData["title"])) }
	}

}
