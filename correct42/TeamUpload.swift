//
//  TeamUpload.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class TeamUpload : SuperModel {
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var finalMark:Int = {
		return (self.jsonData["final_mark"].intValue)
	}()
	
	lazy var comment:String = {
		return (self.jsonData["comment"].stringValue)
	}()
	
	lazy var createdAt:String = {
		return (self.jsonData["created_at"].stringValue)
	}()
	
	
	lazy var uploadId:Int = {
		return (self.jsonData["upload_id"].intValue)
	}()
	
	lazy var upload:Upload = {
		return (Upload(jsonFetch: self.jsonData["upload"]))
	}()
}
