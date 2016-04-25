//
//  Cursus.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SwiftyJSON

class Cursus {
	var jsonData:JSON = JSON("")
	
	// MARK: - Uncomputed (alias) proprieties
	var id
	var name
	var createAt
	var updatedAt
	var slug
	var endAt
	var level
	var grade
	
	var projects:[Project]{
		get{
			
		}
	}
	
	
	// MARK: - Contructors
	init(jsonFetch:JSON){
		jsonData = jsonFetch
	}
}
