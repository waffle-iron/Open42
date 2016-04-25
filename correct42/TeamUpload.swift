//
//  TeamUpload.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class TeamUpload : SuperModel {
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}

	var finalMark:Int{
		get{ return (jsonData["final_mark"].intValue) }
		set{ jsonData["final_mark"].int = newValue }
	}

	
	
	var comment:String{
		get{ return (jsonData["comment"].stringValue) }
		set{ jsonData["comment"].string = newValue }
	}

	var createdAt:String{
		get{ return (jsonData["created_at"].stringValue) }
		set{ jsonData["created_at"].string = newValue }
	}

	
	var uploadId:Int{
		get{ return (jsonData["upload_id"].intValue) }
		set{ jsonData["upload_id"].int = newValue }
	}

	var upload:Upload{
		get{ return (Upload(jsonFetch: jsonData["upload"])) }
	}

}
