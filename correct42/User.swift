//
//  user.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SwiftyJSON

class User{
	var jsonData:JSON = JSON("")
	
	// MARK: - Uncomputed (alias) proprieties
	var id:Int {
		get{
			return (jsonData["id"].intValue)
		}
		set{
			jsonData["id"].int = newValue
		}
	}
	
	var email:String {
		get{
			return (jsonData["email"].stringValue)
		}
		set{
			jsonData["email"].string = newValue
		}
	}
	
	var login:String {
		get{
			return (jsonData["login"].stringValue)
		}
		set{
			jsonData["login"].string = newValue
		}
	}
	
	var url:String {
		get{
			return (jsonData["url"].stringValue)
		}
		set{
			jsonData["url"].string = newValue
		}
	}
	
	var phone:String {
		get{
			return (jsonData["phone"].stringValue)
		}
		set{
			
		}
	}
	
	var displayName:String {
		get{
			return (jsonData["displayname"].stringValue)
		}
		set{
			
		}
	}
	
	var imageUrl:String {
		get{
			return (jsonData["image_url"].stringValue)
		}
		set{
			
		}
	}
	
	var staff:Bool {
		get{
			return (jsonData["email"].boolValue)
		}
		set{
			
		}
	}
	
	var correctionPoint:Int {
		get{
			return (jsonData["correction_point"].intValue)
		}
	}

	var poolMonth:String {
		get{
			return (jsonData["pool_month"].stringValue)
		}
	}

	var poolYear:String {
		get{
			return (jsonData["pool_year"].stringValue)
		}
	}

	var location:String {
		get{
			return (jsonData["location"].stringValue)
		}
	}

	var wallet:Int {
		get{
			return (jsonData["wallet"].intValue)
		}
	}
	
	// TODO: Finish implement of Cursus
	var cursus:[Cursus] {
		get {
			let cursusGet = [Cursus]()
			for cursus in jsonData["cursus"].arrayValue {
				cursusGet.
			}
			return (cursusGet)
		}
	}
	
	// TODO: Finish implement of Skills
	var skills:[Skill] {
		get {
			var skillsGet = [Skill]()
			for skill in jsonData["skills"].arrayValue{
			}
			return (skillsGet)
		}
	}
	
	// TODO: Finish implement of Achievement
	var achievements:[Achievement] {
		get {
			var achievementGet = [Achievement]()
			for achievement in jsonData["achievements"].arrayValue{
			}
			return (achievementGet)
		}
	}
	
	var titles:[String] {
		get {
			var titlesGet = [String]()
			for title in jsonData["titles"].arrayValue{
				titlesGet.append(title.stringValue)
			}
			return (titlesGet)
		}
	}
	
	// TODO: Finish implement of Campus
	var achievements:[Campus] {
		get {
			var achievementGet = [Campus]()
			for achievement in jsonData["Campus"].arrayValue{
			}
			return (achievementGet)
		}
	}
	
	init(jsonFetch:JSON){
		jsonData = jsonFetch
	}

}