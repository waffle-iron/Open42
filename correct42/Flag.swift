//
//  Flag.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Flag : SuperModel, IdDelegate, DateDelegate{
	
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var positive:Bool{
		get{ return (jsonData["positive"].boolValue) }
		set{ jsonData["positive"].bool = newValue }
	}
	
	var icon:String{
		get{ return (jsonData["icon"].stringValue) }
		set{ jsonData["icon"].string = newValue }
	}
	
	var createdAt:String{
		get{ return (jsonData["created_at"].stringValue) }
		set{ jsonData["created_at"].string = newValue }
	}
	
	var updatedAt:String{
		get{ return (jsonData["updated_at"].stringValue) }
		set{ jsonData["updated_at"].string = newValue }
	}
}
