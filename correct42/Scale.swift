//
//  Scale.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Scale: SuperModel, IdDelegate{
	
	var id:Int{
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
	
	var evaluationId:Int{
		get{ return (jsonData["evaluation_id"].intValue) }
		set{ jsonData["evaluation_id"].int = newValue }
	}

	
	var isPrimary:Bool{
		get{ return (jsonData["is_primary"].boolValue) }
		set{ jsonData["is_primary"].bool = newValue }
	}

	
	
	var comment:String{
		get{ return (jsonData["comment"].stringValue) }
		set{ jsonData["comment"].string = newValue }
	}

	var introductionMd:String{
		get{ return (jsonData["introduction_md"].stringValue) }
		set{ jsonData["introduction_md"].string = newValue }
	}

	var disclamerMd:String{
		get{ return (jsonData["disclamer_md"].stringValue) }
		set{ jsonData["disclamer_md"].string = newValue }
	}

	var guidelineMd:String{
		get{ return (jsonData["guideline_md"].stringValue) }
		set{ jsonData["guideline_md"].string = newValue }
	}

	var createdAt:String{
		get{ return (jsonData["created_at"].stringValue) }
		set{ jsonData["created_at"].string = newValue }
	}

	
	var correctionNumber:Int{
		get{ return (jsonData["correction_number"].intValue) }
		set{ jsonData["evaluation_id"].int = newValue }
	}

	var duration:Int{
		get{ return (jsonData["duration"].intValue) }
		set{ jsonData["duration"].int = newValue }
	}

	
	var manualSubscription:Bool{
		get{ return (jsonData["staff?"].boolValue) }
		set{ jsonData["staff?"].bool = newValue }
	}

	
	var language:Language{
		get{ return (Language(jsonFetch: jsonData["language"])) }
	}

}