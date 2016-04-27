//
//  Protocol.swift
//  correct42
//
//  Created by larry on 27/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Alamofire

protocol ApiRouter {
	func route() -> (Method, String)
	var method:Method{get}
	var path:String{get}
}
