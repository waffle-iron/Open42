//
//  Scale.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Scale: SuperModel, IdDelegate{
	
	lazy var id:Int = {
		return (self.jsonData["id"].intValue)
	}()
	
	lazy var name:String = {
		return (self.jsonData["name"].stringValue)
	}()
	
	lazy var evaluationId:Int = {
		return (self.jsonData["evaluation_id"].intValue)
	}()
	
	
	lazy var isPrimary:Bool = {
		return (self.jsonData["is_primary"].boolValue)
	}()
	
	
	
	lazy var comment:String = {
		return (self.jsonData["comment"].stringValue)
	}()
	
	lazy var introductionMd:String = {
		return (self.jsonData["introduction_md"].stringValue)
	}()
	
	lazy var disclamerMd:String = {
		return (self.jsonData["disclamer_md"].stringValue)
	}()
	
	lazy var guidelineMd:String = {
		return (self.jsonData["guideline_md"].stringValue)
	}()
	
	lazy var createdAt:String = {
		return (self.jsonData["created_at"].stringValue)
	}()
	
	
	lazy var correctionNumber:Int = {
		return (self.jsonData["correction_number"].intValue)
	}()
	
	lazy var duration:Int = {
		return (self.jsonData["duration"].intValue)
	}()
	
	
	lazy var manualSubscription:Bool = {
		return (self.jsonData["staff?"].boolValue)
	}()
	
	
	lazy var language:Language = {
		return (Language(jsonFetch: self.jsonData["language"]))
	}()
}