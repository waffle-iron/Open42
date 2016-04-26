//
//  Cursus.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SwiftyJSON

class Cursus : SuperModel, IdDelegate{
	
	// MARK: - Uncomputed (alias) proprieties
	lazy var id:Int  = {
		return (self.jsonData["cursus"]["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["cursus"]["name"].stringValue)
	}()
	
	lazy var createAt:String = {
		return (self.jsonData["cursus"]["create_at"].stringValue)
	}()
	
	lazy var updatedAt:String = {
		return (self.jsonData["cursus"]["update_at"].stringValue)
	}()
	
	lazy var slug:String = {
		return (self.jsonData["cursus"]["slug"].stringValue)
	}()
	
	lazy var endAt:String = {
		return (self.jsonData["end_at"].stringValue)
	}()
	
	lazy var level:Int = {
		return (self.jsonData["level"].intValue)
	}()
	
	lazy var grade:String = {
		return (self.jsonData["grade"].stringValue)
	}()
	
	lazy var projects:[Project] = {
			var projectGet = [Project]()
			for project in self.jsonData["Projects"].arrayValue{
				projectGet.append(Project(jsonFetch: project))
			}
			return (projectGet)
	}()
}
