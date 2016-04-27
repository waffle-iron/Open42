//
//  ApiCredential.swift
//  correct42
//
//  Created by larry on 27/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class ApiCredential{
	
	private let protectionSpace = NSURLProtectionSpace(host: "api", port: -1, protocol: "http", realm: nil, authenticationMethod: nil)
	
	static let sharedInstance = ApiCredential()
	
	static func Shared() -> ApiCredential {
		return (self.sharedInstance)
	}
	
	var token:String?{
		get{
			return (fetchToken())
		}
		set{
			setToken(newValue!)
		}
	}
	
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
	
	private func setToken(token:String){
		let credentialStorage = NSURLCredential(user: "token", password: token, persistence: .Permanent)
		NSURLCredentialStorage.sharedCredentialStorage().setCredential(credentialStorage, forProtectionSpace: protectionSpace)
	}
	
}
