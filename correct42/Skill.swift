//
//  Skill.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Skill: SuperModel, IdDelegate {
	lazy var id:Int  = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var level:Int = {
		return (self.jsonData["level"].intValue)
	}()
}
