//
//  ApiCredential.swift
//  correct42
//
//  Created by larry on 27/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

/// Credential token for the API
class ApiCredential{
	
	/// Fetch the protection space of the Api needed. Here we have just 1 API.
	private let protectionSpace = NSURLProtectionSpace(host: "api", port: -1, protocol: "http", realm: nil, authenticationMethod: nil)
	
	/// static Instance of the APICredential
	static let sharedInstance = ApiCredential()
	
	/**
	Give the singleton object of the APICredential
	
	```
	let mySharedAPICredential = APICredential.Shared()
	```
	
	- returns: `static let instance`
	*/
	static func Shared() -> ApiCredential {
		return (self.sharedInstance)
	}
	
	var token:String?{
		get{
			return (fetchToken())
		}
		set{
			print("set Token : \(newValue)")
			setToken(newValue!)
		}
	}

	/**
	Fetch the token from the NSURLCredentialStorage
	- Returns: String Token of the API.
	*/
	private func fetchToken() -> String?{
		if let oldCred = NSURLCredentialStorage.sharedCredentialStorage().credentialsForProtectionSpace(protectionSpace){
			if let tupleToken = oldCred.first{
				let credentialToken = tupleToken.1
				if credentialToken.hasPassword{
					if let pass = credentialToken.password{
						return pass
					}
				}
			}
		}
		return nil
	}
	
	/**
	Set the token in the NSURLCredentialStorage
	- Parameter token : Token string of the API
	*/
	private func setToken(token:String){
		let credentialStorage = NSURLCredential(user: "token", password: token, persistence: .Permanent)
		NSURLCredentialStorage.sharedCredentialStorage().setCredential(credentialStorage, forProtectionSpace: protectionSpace)
	}
	
}
