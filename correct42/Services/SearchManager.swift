//
//  SearchManager.swift
//  correct42
//
//  Created by larry on 23/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Foundation

class SearchManager {
	// MARK: - Singleton
	/// static Instance of the Search Manager
	static let instance = SearchManager()
	
	/**
	Give the singleton object of the SearchManager
	
	```
	let listUsers = SearchManager.Shared()
	```
	
	- returns: `static let instance`
	*/
	static func Shared() -> SearchManager {
		return (instance)
	}
	
	// MARK: - Delegations
	var delegate:SearchManagerDelegation?
	
	// MARK: - Proprieties
	/// Array of Users
	lazy var listSearchUser:[User] = [User]()
	
	/// Count the current fetched page.
	lazy var currentPage = 0
	
	/// Services to fetch list of all the user
	lazy var apiRequester = ApiRequester.Shared()
	
	/// constante of the file name
	let pathFile = "usersNameListV1.1.1.txt"
	
	/// Content file of the file at `pathFile`
	var contentFile = ""
	
	/// fetch directory of the user list file
	lazy var dir:String? = {
		let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
		guard (dirs.count > 0) else {
			return nil
		}
		
		var dirRet = dirs[0]
		dirRet.appendContentsOf(self.pathFile)
		return (dirRet)
	}()

	/// lazy Boolean checking if the users are already fetch
	func fileAlreadyExist() -> Bool {
		if let path = self.dir {
			return NSFileManager().fileExistsAtPath(path)
		}
		else {
			return (false)
		}
	}
	
	// MARK: - List Methods
	/**
	Fetch Users name in `usersNameList.txt`
	*/
	func fetchUsersOnAPI(pageNumber:Int , onCompletion:(Bool,NSError!)->Void){
		if let path = dir{
			self.currentPage = pageNumber + 1
			apiRequester.request(UserRouter.SearchPage(self.currentPage), success: { (jsonData) in
				if (jsonData.arrayValue.count > 0){
					for userInfos in jsonData.arrayValue {
						let user = User(jsonFetch: userInfos)
						var userInfos = user.login
						let userId = ":\(user.id)"
						
						// Construct data user
						userInfos.appendContentsOf(userId)
						userInfos.appendContentsOf("\n")
						self.contentFile.appendContentsOf(userInfos)
						if let delegation = self.delegate {
							if let delegateCompletionPercent = delegation.searchManager {
								delegateCompletionPercent(percentOfCompletion: self.knowPercentAlpha(userInfos.lowercaseString.characters.first!))
							}
						}
					}
					self.fetchUsersOnAPI(self.currentPage, onCompletion: onCompletion)
				} else {
					do {
						try self.contentFile.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
					} catch {
						print(NSError(domain: "Search Manager", code: -1, userInfo: [1:"error writing User list to file"]))
					}
					self.fetchUsersOnFile(onCompletion)
				}
			}) { (error) in
				onCompletion(false, NSError(domain: "Search Manager", code: -1, userInfo: [1:"Error loading all the user."]))
			}
		} else {
			onCompletion(false, NSError(domain: "Search Manager", code: -1, userInfo: [1:"Error creating 42 users file list."]))
		}
	}
	
	/**
	Read Users login in `usersNameList.txt` and fill the listSearchUser var
	*/
	func fetchUsersOnFile(onCompletion: (Bool,NSError!)->Void){
		if let path = dir{
			if fileAlreadyExist() {
				do {
					let fileContent = try String(contentsOfFile: path, usedEncoding: nil)
					let InfosUsers = fileContent.componentsSeparatedByString("\n")
					for InfosUser in InfosUsers {
						if (InfosUser != ""){
							let InfoUser = InfosUser.componentsSeparatedByString(":")
							if let idUser:Int = Int(InfoUser[1]){
								listSearchUser.append(User(login: InfoUser[0], id: idUser))
							}
						}
					}
					onCompletion(true, nil)
				} catch {
					onCompletion(false, NSError(domain: "Search Manager", code: -1, userInfo: ["Error":"Error oppening 42 users file list."]))
				}
				return
			} else {
				onCompletion(false, NSError(domain: "Search Manager", code: -1, userInfo: ["Error":"42 users file list not found."]))
			}
		} else {
			onCompletion(false, NSError(domain: "Search Manager", code: -1, userInfo: ["Error":"Error on composing path"]))
		}
	}
	
	// MARK: - Private methods
	/// To know percent compared to the letter in alphabet
	private func knowPercentAlpha(letter:Character) -> Int{
		let asciiInt = letter.unicodeScalarCodePoint()
		let percent = (asciiInt - 97) * 100 / 25
		return (Int(percent))
	}
}

private extension Character
{
	func unicodeScalarCodePoint() -> UInt32
	{
		let characterString = String(self)
		let scalars = characterString.unicodeScalars
		
		return scalars[scalars.startIndex].value
	}
}
