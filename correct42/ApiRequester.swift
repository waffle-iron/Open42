//
//  APIManager.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Alamofire
import OAuthSwift
import SwiftyJSON
import SafariServices

class ApiRequester {
	
	//MARK: - Singleton
	static let sharedInstance = ApiRequester()
	
	static func Shared() -> ApiRequester
	{
		return (self.sharedInstance)
	}
	
	//MARK: - Proprieties
	var baseURLString = "https://api.intra.42.fr/v2"
	
	//MARK: - Credentials
	lazy var apiCredential = ApiCredential.Shared()
	
	//MARK: - Methods
	/*
	** Send request to api server with a router Enum and execute callback.
	*/
	func request(router:ApiRouter, success: (JSON)->Void, failure:(NSError)->Void)
	{
		let URL = NSURL(string: baseURLString)!
		let completeRoute = NSURLRequest(URL: URL.URLByAppendingPathComponent(router.path))
		Alamofire.request(router.method, completeRoute, headers: ["Authorization":"Bearer \(apiCredential.token)"])
			.response { request, response, data, error in
				guard error == nil else { failure(error!); return }
				guard data == nil else { failure(NSError(domain: "nil on data and no error network", code: -1, userInfo: nil)); return }
				success(JSON(data!));
		}
	}
	
	/*
	** Fetch api Token by asking it to the user with webview his ids and execute
	** corresponding callback.
	*/
	func connectApi(viewController:UIViewController, delegateSafari:SFSafariViewControllerDelegate, success:(Void)->Void, failure:(NSError)->Void)
	{
		let oauthswift = OAuth2Swift(
			consumerKey:    "a94a2723cbc81403ded70bb83444030dd15f47f3c0469bfe9b576cf648739291",
			consumerSecret: "e8011d26fe85872ae11016065a01aa41274740b2ee0f6fb9f962b2c8eb74ba2f",
			authorizeUrl:   "https://api.intra.42.fr/oauth/authorize",
			accessTokenUrl: "https://api.intra.42.fr/oauth/token",
			responseType:   "code"
		)
		let safariView = SafariURLHandler(viewController: viewController)
		safariView.delegate = delegateSafari
		oauthswift.authorize_url_handler = safariView
		
		oauthswift.authorizeWithCallbackURL(
			NSURL(string: "correct42://oauth-callback/intra")!,
			scope: "public", state:"INTRA",
			success: { credential, response, parameters in
				self.apiCredential.token = credential.oauth_token
				success()
			},
			failure: { error in
				failure(error)
			}
		)
	}
}

