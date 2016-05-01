//
//  Team.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Team : SuperModel, DateDelegate {
	
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var url:String = {
		return (self.jsonData["url"].stringValue)
	}()
	
	
	lazy var finalMark:Int = {
		return (self.jsonData["final_mark"].intValue)
	}()
	
	lazy var projectId:Int = {
		return (self.jsonData["project_id"].intValue)
	}()
	
	
	lazy var createdAt:String = {
		return (self.jsonData["created_at"].stringValue)
	}()
	
	lazy var updatedAt:String = {
		return (self.jsonData["updated_at"].stringValue)
	}()
	
	lazy var users:[User] = {
		var userGet = [User]()
		for user in self.jsonData["users"].arrayValue {
			userGet.append(User(jsonFetch: user))
		}
		return (userGet)
	}()
	
	lazy var locked:Bool = {
		return (self.jsonData["staff?"].boolValue)
	}()
	
	lazy var closed:Bool = {
		return (self.jsonData["staff?"].boolValue)
	}()
	
	
	
	lazy var repoUrl:String = {
		return (self.jsonData["repo_url"].stringValue)
	}()
	
	lazy var repoUuid:String = {
		return (self.jsonData["repo_uuid"].stringValue)
	}()
	
	lazy var lockedAt:String = {
		return (self.jsonData["locked_at"].stringValue)
	}()
	
	lazy var closedAt:String = {
		return (self.jsonData["closed_at"].stringValue)
	}()
	
	
	lazy var scaleTeams:[ScaleTeam] = {
		var scaleTeamsGet = [ScaleTeam]()
		for scaleTeam in self.jsonData["scale_teams"].arrayValue {
			scaleTeamsGet.append(ScaleTeam(jsonFetch: scaleTeam))
		}
		return (scaleTeamsGet)
	}()
	
	lazy var teamsUploads:[TeamUpload] = {
		var teamsUploadsGet = [TeamUpload]()
		for teamUpload in self.jsonData["teams_uploads"].arrayValue {
			teamsUploadsGet.append(TeamUpload(jsonFetch: teamUpload))
		}
		return (teamsUploadsGet)
	}()
}
