//
//  UserRoute.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

enum UserRouter: ApiRouter {

	case ReadUser(Int)
	case Me
	case Search(String)
	
	// MARK: Depend on Case proprieties
	var method: Alamofire.Method {
		switch self {
		case .ReadUser:
			return .GET
		case .Me:
			return .GET
		case .Search:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .ReadUser(let id):
			return "/users/\(id)"
		case .Me:
			return "/me"
		case .Search:
			return "/users"
		}
	}
	
	var parameters:String{
		switch self {
		case .Search(let login):
			return "?search=in:login%20\(login)"
		default:
			return ""
		}
	}
	
	
	// MARK: - ApiRouter methods
	/*
	** return complete path of api
	*/
	func route() -> (Method, String, String)
	{
		return (method, path, parameters)
	}
}
