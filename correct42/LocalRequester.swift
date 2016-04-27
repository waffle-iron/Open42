//
//  LocalRequester.swift
//  correct42
//
//  Created by larry on 27/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

class LocalRequester {
	//MARK: - Singleton
	static let sharedInstance = LocalRequester()
	
	static func Shared() -> LocalRequester
	{
		return (self.sharedInstance)
	}
	
	//MARK: - Methods
	func fetch(){
		
	}
	
	func save(){
		
	}
	
	func remove(){
		
	}
}
