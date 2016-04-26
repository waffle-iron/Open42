//
//  Flag.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Flag : SuperModel, IdDelegate, DateDelegate{
	
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var positive:Bool = {
		return (self.jsonData["positive"].boolValue)
	}()
	
	lazy var icon:String = {
		return (self.jsonData["icon"].stringValue)
	}()
	
	lazy var createdAt:String = {
		return (self.jsonData["created_at"].stringValue)
	}()
	
	lazy var updatedAt:String = {
		return (self.jsonData["updated_at"].stringValue)
	}()
}
