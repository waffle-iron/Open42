//
//  user.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SwiftyJSON

class User : SuperModel, IdDelegate {
	
	// MARK: - Uncomputed (alias) proprieties
	var id:Int {
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String {
		get{ return (displayName) }
		set{ displayName = newValue }
	}
	
	var email:String {
		get{ return (jsonData["email"].stringValue) }
		set{ jsonData["email"].string = newValue }
	}
	
	var login:String {
		get{ return (jsonData["login"].stringValue) }
		set{ jsonData["login"].string = newValue }
	}
	
	var url:String {
		get{ return (jsonData["url"].stringValue) }
		set{ jsonData["url"].string = newValue }
	}
	
	var phone:String {
		get{ return (jsonData["phone"].stringValue) }
		set{ jsonData["phone"].string = newValue }
	}
	
	var displayName:String {
		get{ return (jsonData["displayname"].stringValue) }
		set{ jsonData["displayname"].string = newValue }
	}
	
	var imageUrl:String {
		get{ return (jsonData["image_url"].stringValue) }
		set{ jsonData["image_url"].string = newValue }
	}
	
	var staff:Bool {
		get{ return (jsonData["staff?"].boolValue) }
		set{ jsonData["staff?"].bool = newValue }
	}
	
	var correctionPoint:Int {
		get{ return (jsonData["correction_point"].intValue) }
		set{ jsonData["correction_point"].int = newValue }
	}

	var poolMonth:String {
		get{ return (jsonData["pool_month"].stringValue) }
		set{ jsonData["pool_month"].string = newValue }
	}

	var poolYear:String {
		get{ return (jsonData["pool_year"].stringValue) }
		set{ jsonData["pool_year"].string = newValue }
	}

	var location:String {
		get{ return (jsonData["location"].stringValue) }
		set{ jsonData["location"].string = newValue }
	}

	var wallet:Int {
		get{ return (jsonData["wallet"].intValue) }
		set{ jsonData["wallet"].int = newValue }
	}
	
	var cursus:[Cursus] {
		get {
			var cursusGet = [Cursus]()
			for cursus in jsonData["cursus"].arrayValue {
				cursusGet.append(Cursus(jsonFetch: cursus))
			}
			return (cursusGet)
		}
	}
	
	var skills:[Skill] {
		get {
			var skillsGet = [Skill]()
			for skill in jsonData["skills"].arrayValue{
				skillsGet.append(Skill(jsonFetch: skill))
			}
			return (skillsGet)
		}
	}
	
	var achievements:[Achievement] {
		get {
			var achievementGet = [Achievement]()
			for achievement in jsonData["achievements"].arrayValue{
				achievementGet.append(Achievement(jsonFetch: achievement))
			}
			return (achievementGet)
		}
	}
	
	var titles:[Title] {
		get {
			var titlesGet = [Title]()
			for title in jsonData["titles"].arrayValue{
				titlesGet.append(Title(jsonFetch: title))
			}
			return (titlesGet)
		}
	}
	
	var patroned:[User]{
		get {
			var userGet = [User]()
			for user in jsonData["patroned"].arrayValue{
				userGet.append(User(jsonFetch: user))
			}
			return (userGet)
		}
	}
	
	var patroning:[User]{
		get {
			var userGet = [User]()
			for user in jsonData["patroning"].arrayValue{
				userGet.append(User(jsonFetch: user))
			}
			return (userGet)
		}
	}

	var campus:[Campus] {
		get {
			var campusGet = [Campus]()
			for campus in jsonData["Campus"].arrayValue{
				campusGet.append(Campus(jsonFetch: campus))
			}
			return (campusGet)
		}
	}
}