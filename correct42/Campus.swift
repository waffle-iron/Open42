//
//  Campus.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import SwiftyJSON

class Campus: SuperModel, IdDelegate {
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var timeZone:String = {
		return (self.jsonData["time_zone"].stringValue)
	}()
	
	lazy var language:Language = {
		return (Language(jsonFetch: self.jsonData["language"]))
	}()
	
	lazy var usersCount:Int = {
		return (self.jsonData["users_count"].intValue)
	}()
}
