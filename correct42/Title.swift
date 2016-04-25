//
//  Title.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Title: SuperModel, IdDelegate {
	var id:Int {
		get{ return (jsonData["id"].intValue) }
		set{ jsonData["id"].int = newValue }
	}
	
	var name:String{
		get{ return (jsonData["name"].stringValue) }
		set{ jsonData["name"].string = newValue }
	}
}
