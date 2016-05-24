//
//  user.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SwiftyJSON

class User : SuperModel {
	
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var email:String = {
		return (self.jsonData["email"].stringValue)
	}()
	
	lazy var login:String = {
		return (self.jsonData["login"].stringValue)
	}()
	
	lazy var url:String = {
		return (self.jsonData["url"].stringValue)
	}()
	
	lazy var phone:String = {
		return (self.jsonData["phone"].stringValue)
	}()
	
	lazy var displayName:String = {
		return (self.jsonData["displayname"].stringValue)
	}()
	
	lazy var imageUrl:String = {
		return (self.jsonData["image_url"].stringValue)
	}()
	
	lazy var staff:Bool = {
		return (self.jsonData["staff?"].boolValue)
	}()
	
	lazy var correctionPoint:Int = {
		return (self.jsonData["correction_point"].intValue)
	}()
	
	lazy var poolMonth:String = {
		return (self.jsonData["pool_month"].stringValue)
	}()
	
	lazy var poolYear:String = {
		return (self.jsonData["pool_year"].stringValue)
	}()
	
	lazy var location:String = {
		return (self.jsonData["location"].stringValue)
	}()
	
	lazy var wallet:Int = {
		return (self.jsonData["wallet"].intValue)
	}()
	
	lazy var cursus:[Cursus] = {
		var cursusGet = [Cursus]()
		for cursus in self.jsonData["cursus"].arrayValue {
			cursusGet.append(Cursus(jsonFetch: cursus))
		}
		return (cursusGet)
	}()
	
	lazy var achievements:[Achievement] = {
		var achievementGet = [Achievement]()
		for achievement in self.jsonData["achievements"].arrayValue{
			achievementGet.append(Achievement(jsonFetch: achievement))
		}
		return (achievementGet)
	}()
	
	lazy var titles:[Title] = {
		var titlesGet = [Title]()
		for title in self.jsonData["titles"].arrayValue{
			titlesGet.append(Title(jsonFetch: title))
		}
		return (titlesGet)
	}()
	
	lazy var patroned:[User] = {
		var userGet = [User]()
		for user in self.jsonData["patroned"].arrayValue{
			userGet.append(User(jsonFetch: user))
		}
		return (userGet)
	}()
	
	lazy var patroning:[User] = {
		var userGet = [User]()
		for user in self.jsonData["patroning"].arrayValue{
			userGet.append(User(jsonFetch: user))
		}
		return (userGet)
	}()
	
	lazy var campus:[Campus] = {
		var campusGet = [Campus]()
		for campus in self.jsonData["Campus"].arrayValue{
			campusGet.append(Campus(jsonFetch: campus))
		}
		return (campusGet)
	}()
	
	init(login:String, id:Int){
		super.init(jsonFetch: "")
		self.login = login
		self.id = id
	}
	
	required init(jsonFetch:JSON){
		super.init(jsonFetch: jsonFetch)
	}
}