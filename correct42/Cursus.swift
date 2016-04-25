//
//  Cursus.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SwiftyJSON

class Cursus : SuperModel, IdDelegate, DateDelegate {
	
	// MARK: - Uncomputed (alias) proprieties
	var id:Int {
		get{ return (jsonData["cursus"]["id"].intValue) }
		set{ jsonData["cursus"]["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["cursus"]["name"].stringValue) }
		set{ jsonData["cursus"]["name"].string = newValue }
	}
	
	var createAt:String{
		get{ return (jsonData["cursus"]["create_at"].stringValue) }
		set{ jsonData["cursus"]["create_at"].string = newValue }
	}
	
	var updatedAt:String{
		get{ return (jsonData["cursus"]["update_at"].stringValue) }
		set{ jsonData["cursus"]["update_at"].string = newValue }
	}
	
	var slug:String{
		get{ return (jsonData["cursus"]["slug"].stringValue) }
		set{ jsonData["cursus"]["slug"].string = newValue }
	}
	
	var endAt:String{
		get{ return (jsonData["end_at"].stringValue) }
		set{ jsonData["end_at"].string = newValue }
	}
	
	var level:Int{
		get{ return (jsonData["level"].intValue) }
		set{ jsonData["level"].int = newValue }
	}
	
	var grade:String{
		get{ return (jsonData["grade"].stringValue) }
		set{ jsonData["grade"].string = newValue }
	}
	
	var projects:[Project]{
		get{
			var projectGet = [Project]()
			for project in jsonData["Projects"].arrayValue{
				projectGet.append(Project(project))
			}
			return (projectGet)
		}
	}
}
