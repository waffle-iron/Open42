//
//  Language.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Language : SuperModel {
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var identifier:String{
		get{ return (jsonData["identifier"].stringValue) }
		set{ jsonData["identifier"].string = newValue }
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
