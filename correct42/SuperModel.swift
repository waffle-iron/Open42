//
//  SuperModel.swift
//  correct42
//
//  Created by larry on 25/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import SwiftyJSON

class SuperModel {
	
	var jsonData:JSON = JSON("")
	
	required init(jsonFetch:JSON){
		jsonData = jsonFetch
	}
}