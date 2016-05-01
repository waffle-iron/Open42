//
//  project.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Project : SuperModel{
	
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var registeredAt:String = {
		return (self.jsonData["registred_at"].stringValue)
	}()
	
	lazy var slug:String = {
		return (self.jsonData["slug"].stringValue)
	}()
	
	lazy var finalMark:Int = {
		return (self.jsonData["final_mark"].intValue)
	}()
	
	lazy var occurence:Int = {
		return (self.jsonData["occurence"].intValue)
	}()
	
	lazy var projectUserId:Int = {
		return (self.jsonData["project_user_id"].intValue)
	}()
	
	lazy var retriableAt:String = {
		return (self.jsonData["retriable_at"].stringValue)
	}()
	
	lazy var teamsIds:[Int] = {
		var teamsIdsGet = [Int]()
		for teamId in self.jsonData["teams_id"].arrayValue{
			teamsIdsGet.append(teamId.intValue)
		}
		return (teamsIdsGet)
	}()
	
	lazy var currentTeam:Team = {
		return (Team(jsonFetch: self.jsonData["current_team"]))
	}()
}