//
//  ScaleTeam.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class ScaleTeam : SuperModel {
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}

	var scaleId:Int{
		get{ return (jsonData["scale_id"].intValue) }
		set{ jsonData["scale_id"].int = newValue }
	}

	var team:Int{
		get{ return (jsonData["team"].intValue) }
		set{ jsonData["team"].int = newValue }
	}

	
	var comment:String{
		get{ return (jsonData["comment"].stringValue) }
		set{ jsonData["comment"].string = newValue }
	}

	var createdAt:String{
		get{ return (jsonData["created_at"].stringValue) }
		set{ jsonData["created_at"].string = newValue }
	}

	var updatedAt:String{
		get{ return (jsonData["updated_at"].stringValue) }
		set{ jsonData["updated_at"].string = newValue }
	}

	var feedback:String{
		get{ return (jsonData["feedback"].stringValue) }
		set{ jsonData["feedback"].string = newValue }
	}

	
	var feedBackRating:Int{
		get{ return (jsonData["feedBack_rating"].intValue) }
		set{ jsonData["feedBack_rating"].int = newValue }
	}
	var finalMark:Int{
		get{ return (jsonData["final_mark"].intValue) }
		set{ jsonData["final_mark"].int = newValue }
	}

	
	var flag:Flag{
		get{ return (Flag(jsonFetch: jsonData["flag"])) }
	}

	
	var beginAt:String{
		get{ return (jsonData["begin_at"].stringValue) }
		set{ jsonData["begin_at"].string = newValue }
	}

	
	var correcteds:[User]{
		get {
			var userGet = [User]()
			for user in jsonData["correcteds"].arrayValue {
				userGet.append(User(jsonFetch: user))
			}
			return (userGet)
		}
	}
	
	var corrector:[User]{
		get {
			var userGet = [User]()
			for user in jsonData["corrector"].arrayValue {
				userGet.append(User(jsonFetch: user))
			}
			return (userGet)
		}
	}
	
	var scale:Scale{
		get{ return (Scale(jsonFetch: jsonData["scale"])) }
	}

}
