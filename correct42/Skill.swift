//
//  Skill.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Skill: SuperModel, IdDelegate {
	var id:Int {
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var level:Int{
		get{ return (jsonData["level"].intValue) }
		set{ jsonData["level"].int = newValue }
	}
}
