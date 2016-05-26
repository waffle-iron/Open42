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
	
	// MARK: - Singleton
	static let sharedInstance = ApiRequester()
	
	/**
	Give the singleton object of the ApiRequester.
	
	```
	let apiRequester = APIRequester.Shared()
	```
	
	- returns: `static let sharedInstance`
	*/
	static func Shared() -> ApiRequester
	{
		return (self.sharedInstance)
	}
	
	// MARK: - Credentials
	/// Credential information singleton
	lazy var apiCredential = ApiCredential.Shared()
	
	// MARK: - Methods
	/**
	Send request to api server with an APIRouter inheritance Enum and execute callback.
	
	```
	let apiRequester = APIRequester.Shared()
	apiRequester.request(UserRouter.Me, success:
	{ (fileContent) in
		print(fileContent)
	}
	}) { (error) in
		print(error)
	}
	```
	
	- Parameters:
		- router: ApiRouter protocol. Give the url of the ressource.
		- success: CallBack execute if the request success.
		- failure: CallBack execute if the request fail.
	*/
	func request(router:ApiRouter, success: (JSON)->Void, failure:(NSError)->Void)
	{
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		if let token = apiCredential.token {
		Alamofire.request(router.method, "\(router.baseUrl)\(router.path)\(router.parameters)", headers: ["Authorization":"Bearer \(token)"])
			.responseJSON{ reponse in
				if let jsonData = reponse.result.value{
					let responseJSON = JSON(jsonData);
					if (responseJSON["error"].string == nil){
						success(responseJSON);
					}
					else {
						failure(NSError(domain: "Error on serveur : \(responseJSON["error"].stringValue)", code: -1, userInfo: nil))
					}
				} else {
					failure(NSError(domain: "Data formating failed", code: -1, userInfo: nil))
				}
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			}
		} else {
			failure(NSError(domain: "No token given", code: -2, userInfo: nil))
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
		}
	}
	
	
	/**
	Fetch api Token by asking it to the user with webview his ids and execute
	corresponding callback.
	
	```
	let apiRequester = APIRequester.Shared()
	apiRequester.connectApi(self, self, success:
	{ in
		print("Success !")
	}
	}) { (error) in
		print(error)
	}
	```
	
	- Parameters:
		- viewController: To perform the segway.
		- delegateSafari: To delegate action in a controllers.
		- success: CallBack execute if the request success.
		- failure: CallBack execute if the request fail.
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
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		oauthswift.authorizeWithCallbackURL(
			NSURL(string: "correct42://oauth-callback/intra")!,
			scope: "public", state:"INTRA",
			success: { credential, response, parameters in
				self.apiCredential.token = credential.oauth_token
				success()
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			},
			failure: { error in
				failure(error)
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			}
		)
	}
	
	/**
	Download a Picture from an ApiRouter inheritance Enum and execute callback.
	
	let apiRequester = APIRequester.Shared()
	apiRequester.downloadFile(LigandRouter.Representation("NAG"), success:
	{ (fileContent) in
		print(fileContent)
	}
	}) { (error) in
		print(error)
	}
	
	- Parameters:
		- router: ApiRouter protocol. Give the url of the ressource.
		- success: CallBack execute if the request success, take String for the content of the File.
		- failure: CallBack execute if the request fail.
	*/
	func downloadImage(imageUrl:String, success:(UIImage)->Void, failure:(NSError)->Void){
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		Alamofire.request(.GET, imageUrl).response() {
			(_, _, data, _) in
			if let data = data{
				if let image = UIImage(data: data){
					success(image)
				} else {
					failure(NSError(domain: "Error on casting data to image", code: -1, userInfo: nil))
				}
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			} else {
				failure(NSError(domain: "Error on download image user", code: -1, userInfo: nil))
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			}
		}
	}
	
	/**
	Download a file from an ApiRouter inheritance Enum and execute callback.
	
	let apiRequester = APIRequester.Shared()
	apiRequester.downloadFile(LigandRouter.Representation("NAG"), success:
	{ (fileContent) in
		print(fileContent)
	}
	}) { (error) in
		print(error)
	}
	
	- Parameters:
		- router: ApiRouter protocol. Give the url of the ressource.
		- success: CallBack execute if the request success, take String for the content of the File.
		- failure: CallBack execute if the request fail.
	*/
	func downloadFile(router:ApiRouter, success:(String)->Void, failure:(NSError)->Void){
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		Alamofire.request(router.method, "\(router.baseUrl)\(router.path)\(router.parameters)").response() {
			(_, _, data, _) in
			if let data = data{
				let fileContent = String.init(data: data, encoding: NSUTF8StringEncoding)
				if let content = fileContent{
					success(content)
				} else {
					failure(NSError(domain: "File content is empty", code: -1, userInfo: nil))
				}
			} else {
				failure(NSError(domain: "Error on download pdbFile", code: -1, userInfo: nil))
			}
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
		}
	}
}

