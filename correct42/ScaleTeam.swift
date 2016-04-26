//
//  ScaleTeam.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class ScaleTeam : SuperModel, IdDelegate {
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var scaleId:Int = {
		return (self.jsonData["scale_id"].intValue)
	}()
	
	lazy var team:Int = {
		return (self.jsonData["team"].intValue)
	}()
	
	
	lazy var comment:String = {
		return (self.jsonData["comment"].stringValue)
	}()
	
	lazy var createdAt:String = {
		return (self.jsonData["created_at"].stringValue)
	}()
	
	lazy var updatedAt:String = {
		return (self.jsonData["updated_at"].stringValue)
	}()
	
	lazy var feedback:String = {
		return (self.jsonData["feedback"].stringValue)
	}()
	
	
	lazy var feedBackRating:Int = {
		return (self.jsonData["feedBack_rating"].intValue)
	}()
	
	lazy var finalMark:Int = {
		return (self.jsonData["final_mark"].intValue)
	}()
	
	
	lazy var flag:Flag = {
		return (Flag(jsonFetch: self.jsonData["flag"]))
	}()
	
	
	lazy var beginAt:String = {
		return (self.jsonData["begin_at"].stringValue)
	}()
	
	
	lazy var correcteds:[User] = {
		var userGet = [User]()
		for user in self.jsonData["correcteds"].arrayValue {
			userGet.append(User(jsonFetch: user))
		}
		return (userGet)
	}()
	
	lazy var corrector:[User] = {
		var userGet = [User]()
		for user in self.jsonData["corrector"].arrayValue {
			userGet.append(User(jsonFetch: user))
		}
		return (userGet)
	}()
	
	lazy var scale:Scale = {
		return (Scale(jsonFetch: self.jsonData["scale"]))
	}()

}
