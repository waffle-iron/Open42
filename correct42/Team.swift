//
//  Team.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Team : SuperModel, IdDelegate, DateDelegate {
	
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}

	var url:String{
		get{ return (jsonData["url"].stringValue) }
		set{ jsonData["url"].string = newValue }
	}

	
	var finalMark:Int{
		get{ return (jsonData["final_mark"].intValue) }
		set{ jsonData["final_mark"].int = newValue }
	}
	
	var projectId:Int{
		get{ return (jsonData["project_id"].intValue) }
		set{ jsonData["project_id"].int = newValue }
	}
	
	
	var createdAt:String{
		get{ return (jsonData["created_at"].stringValue) }
		set{ jsonData["created_at"].string = newValue }
	}

	var updatedAt:String{
		get{ return (jsonData["updated_at"].stringValue) }
		set{ jsonData["updated_at"].string = newValue }
	}

	var users:[User]{
		get {
			var userGet = [User]()
			for user in jsonData["users"].arrayValue {
				userGet.append(User(jsonFetch: user))
			}
			return (userGet)
		}
	}
	
	var locked:Bool{
		get{ return (jsonData["staff?"].boolValue) }
		set{ jsonData["staff?"].bool = newValue }
	}

	var closed:Bool{
		get{ return (jsonData["staff?"].boolValue) }
		set{ jsonData["staff?"].bool = newValue }
	}

	
	
	var repoUrl:String{
		get{ return (jsonData["repo_url"].stringValue) }
		set{ jsonData["repo_url"].string = newValue }
	}

	var repoUuid:String{
		get{ return (jsonData["repo_uuid"].stringValue) }
		set{ jsonData["repo_uuid"].string = newValue }
	}

	var lockedAt:String{
		get{ return (jsonData["locked_at"].stringValue) }
		set{ jsonData["locked_at"].string = newValue }
	}

	var closedAt:String{
		get{ return (jsonData["closed_at"].stringValue) }
		set{ jsonData["closed_at"].string = newValue }
	}

	
	var scaleTeams:[ScaleTeam]{
		get {
			var scaleTeamsGet = [ScaleTeam]()
			for scaleTeam in jsonData["scale_teams"].arrayValue {
				scaleTeamsGet.append(ScaleTeam(jsonFetch: scaleTeam))
			}
			return (scaleTeamsGet)
		}
	}
	
	var teamsUploads:[TeamUpload]{
		get {
			var teamsUploadsGet = [TeamUpload]()
			for teamUpload in jsonData["teams_uploads"].arrayValue {
				teamsUploadsGet.append(TeamUpload(jsonFetch: teamUpload))
			}
			return (teamsUploadsGet)
		}
	}
}
