//
//  UserRoute.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

enum UserRouter: ApiRouter {

	// MARK: - Cases
	/**
	This case read an User with his Id
	*/
	case ReadUser(Int)
	
	/**
	This case read the profil of the owner of the token
	*/
	case Me
	
	/**
	This case search list of user who contain the String parameter in there login
	*/
	case Search(String)
	
	/**
	This case fetch all the user page by page
	*/
	case SearchPage(Int)
	
	// MARK: - APIRouter protocols
	/**
	- .ReadUser, .Me, .Search, .SearchPage = .GET
	*/
	var method: Alamofire.Method {
		switch self {
		case .ReadUser, .Me, .Search, .SearchPage:
			return .GET
		}
	}
	
	/**
	- .ReadUser = "/users/\(id)"
	- .Me = "/me"
	- .Search, .SearchPage = "/users"
	*/
	var path: String {
		switch self {
		case .ReadUser(let id):
			return "/users/\(id)"
		case .Me:
			return "/me"
		case .Search, .SearchPage:
			return "/users"
		}
	}
	
	/**
	- .Search = "?search=in:login%20\(login)"
	- .SearchPage = "?page=\(page)&filter=status:admis"
	- default = ""
	*/
	var parameters:String{
		switch self {
		case .Search(let login):
			return "?search=in:login%20\(login)"
		case .SearchPage(let page):
			return "?page=\(page)&filter=status:admis"
		default:
			return ""
		}
	}
	
	/**
	- default = "https://api.intra.42.fr/v2"
	*/
	var baseUrl:String{
		switch self {
		default:
			return "https://api.intra.42.fr/v2"
		}
	}
}
