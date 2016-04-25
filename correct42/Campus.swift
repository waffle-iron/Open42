//
//  Campus.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import SwiftyJSON

class Campus: SuperModel, IdDelegate {
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var timeZone:String{
		get{ return (jsonData["time_zone"].stringValue) }
		set{ jsonData["time_zone"].string = newValue }
	}

	var language:Language{
		get{ return (Language(jsonFetch: jsonData["language"])) }
	}

	var usersCount:Int{
		get{ return (jsonData["users_count"].intValue) }
		set{ jsonData["users_count"].int = newValue }
	}
}
