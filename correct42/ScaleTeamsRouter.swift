//
//  ScaleTeamsRouter.swift
//  correct42
//
//  Created by larry on 15/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

enum ScaleTeamsRouter: ApiRouter {
	
	case Me
	
	// MARK: Depend on Case proprieties
	var method: Alamofire.Method {
		switch self {
		case .Me:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .Me:
			return "/me/scale_teams"
		}
	}
	
	var parameters:String{
		switch self {
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
