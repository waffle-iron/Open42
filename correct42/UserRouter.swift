//
//  UserRoute.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

enum UserRouter: ApiRouter {

	case ReadUser(String)
	
	var method: Alamofire.Method {
		switch self {
		case .ReadUser:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .ReadUser(let username):
			return "/users/\(username)"
		}
	}
	
	/*
	** return complete path of api
	*/
	func route() -> (Method, String)
	{
		return (method, path)
	}
}
