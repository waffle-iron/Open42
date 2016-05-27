//
//  userManager.swift
//  correct42
//
//  Created by larry on 20/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Foundation

class UserManager {
	// MARK: Singleton
	/// Static Instance of the UserManager
	static let sharedInstance = UserManager()
	
	/**
	Give the singleton object of the UserManager
	
	```
	let userManager = UserManager.Shared()
	```
	
	- returns: `static let instance`
	*/
	static func Shared() -> UserManager
	{
		return (self.sharedInstance)
	}
	
	
	// MARK: - Proprieties
	
	/// User owner of the token in the profil tab
	var loginUser:User?
	/// User selected in the search Tab
	var searchUser:User?
	/// User sleected in the correction tab
	var correctionUser:User?
	
	/// Current user in selected tab.
	var currentUser:User?
	
	// MARK: - Services
	/// Singleton of the API
	let apiRequester = ApiRequester.Shared()
	
	// MARK: - Methods
	/**
	Fetch api Token by asking it to the user with webview his ids and execute
	corresponding callback.
	
	```
	let userManager = UserManager.Shared()
	userManager.fetchMyProfil(success:
	{ (user) in
		loginUser = user
		print("Success !")
	}
	}) { (error) in
		print(error)
	}
	```
	
	- Parameters:
		- success: CallBack execute if the request success and take an `User` in parameter.
		- failure: CallBack execute if the request fail.
	*/
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
	
	/**
	Fetch api Token by asking it to the user with webview his ids and execute
	corresponding callback.
	
	```
	let userManager = UserManager.Shared()
	userManager.fetchUserById(success:
	{ (user) in
		searchUser = user //Or CorrectionUser
		print("Success !")
	}
	}) { (error) in
		print(error)
	}
	```
	
	- Parameters:
	- success: CallBack execute if the request success and take an `User` in parameter.
	- failure: CallBack execute if the request fail.
	*/
	func fetchUserById(id:Int, success:(User)->Void, failure:(NSError)->Void){
		apiRequester.request(UserRouter.ReadUser(id), success: { (jsonData) in
				success(User(jsonFetch: jsonData))
		}) { (error) in
			// get local requester if exist else
			failure(error)
		}
		
	}
}
