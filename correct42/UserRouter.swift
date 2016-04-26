//
//  UserRoute.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

enum UserRouter: URLRequestConvertible {
	static let baseURLString = "https://api.intra.42.fr/v2"
	static var OAuthToken: String?
	
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
	
	// MARK: URLRequestConvertible
	
	var URLRequest: NSMutableURLRequest {
		let URL = NSURL(string: UserRouter.baseURLString)!
		let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
		mutableURLRequest.HTTPMethod = method.rawValue
		
		if let token = UserRouter.OAuthToken {
			mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		return mutableURLRequest
	}
}
