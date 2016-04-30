//
//  userManager.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Foundation

class UserManager {
	//MARK: - Singleton
	static let sharedInstance = UserManager()
	
	static func Shared() -> UserManager
	{
		return (self.sharedInstance)
	}
	
	//MARK: - needed
	var loginUser:User?
	var searchUser:User?
	var currentUser:User?
	
	//MARK: - Service Singletons
	let apiRequester = ApiRequester.Shared()
	
	//MARK: -Methods loginUser
	func fetchMyProfil(success:(User)->Void, failure:(NSError)->Void){
		apiRequester.request(UserRouter.Me, success: { (jsonData) in
			self.loginUser = User(jsonFetch: jsonData)
			if let user = self.loginUser {
				success(user)
			} else {
				failure(NSError(domain: "no user", code: -1, userInfo: nil))
			}
			
			}) { (error) in
			// get local requester if exist else
			failure(error)
		}
	}
	
	func fetchSearchUser(pseudo:String, success:(User)->Void, failure:(NSError)->Void){
		apiRequester.request(UserRouter.ReadUser(pseudo), success: { (jsonData) in
			self.searchUser = User(jsonFetch: jsonData)
			if let user = self.loginUser {
				success(user)
			} else {
				failure(NSError(domain: "no user", code: -1, userInfo: nil))
			}
			
		}) { (error) in
			// get local requester if exist else
			failure(error)
		}
	}
}
