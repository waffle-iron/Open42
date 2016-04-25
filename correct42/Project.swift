//
//  project.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Project : SuperModel, IdDelegate {
	
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var registeredAt:String{
		get{ return (jsonData["registred_at"].stringValue) }
		set{ jsonData["registred_at"].string = newValue }
	}
	
	var slug:String{
		get{ return (jsonData["slug"].stringValue) }
		set{ jsonData["slug"].string = newValue }
	}
	
	var finalMark:Int{
		get{ return (jsonData["final_mark"].intValue) }
		set{ jsonData["final_mark"].int = newValue }
	}
	
	var occurence:Int{
		get{ return (jsonData["occurence"].intValue) }
		set{ jsonData["occurence"].int = newValue }
	}
	
	var projectUserId:Int{
		get{ return (jsonData["project_user_id"].intValue) }
		set{ jsonData["project_user_id"].int = newValue }
	}
	
	var retriableAt:String{
		get{ return (jsonData["retriable_at"].stringValue) }
		set{ jsonData["retriable_at"].string = newValue }
	}
	
	var teamsIds:[Int]{
		get{
			var teamsIdsGet = [Int]()
			for teamId in jsonData["teams_id"].arrayValue{
				teamsIdsGet.append(teamId.intValue)
			}
			return (teamsIdsGet)
		}
	}
	
	var currentTeam:Team{
		get{ return (Team(jsonData["current_team"])) }
	}
}