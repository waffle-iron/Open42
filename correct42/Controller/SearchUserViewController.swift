//
//  SearchUserViewController.swift
//  correct42
//
//  Created by larry on 02/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

	//MARK: - UIView Links
	@IBOutlet weak var resultTableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	//MARK: - Needed
	let userManager = UserManager.Shared()
	let searchManager = SearchManager.Shared()
	let cellName = "searchUserCell"
	var userList = [User]()
	var performRequest = false
	
	
	//MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		//Register user list cell
		let nib = UINib(nibName: cellName, bundle: nil)
		resultTableView.registerNib(nib, forCellReuseIdentifier: cellName)
		resultTableView.delegate = self
		resultTableView.dataSource = self
		searchBar.delegate = self

		self.userList = searchManager.listSearchUser
		self.resultTableView.reloadData()
    }
	
	//MARK: - Other methods
	func searchValueOnAPI(value:String){
		if (value != ""){
			self.userList.removeAll()
			self.userList = searchManager.listSearchUser.filter{$0.login.localizedCaseInsensitiveContainsString(value)}
			self.resultTableView.reloadData()
		} else {
			self.userList.removeAll()
			self.userList = searchManager.listSearchUser
			self.resultTableView.reloadData()
		}
	}
	
	//MARK: - Search Bar delegation
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		searchValueOnAPI(searchText)
	}
	
	//MARK: - Table delegation
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (userList.count)
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if (!performRequest){
			performRequest = true
			userManager.fetchUserById(userList[indexPath.row].id, success: { (user) in
					self.performRequest = false
					self.userManager.searchUser = user
					self.performSegueWithIdentifier("goToUserSearch", sender: self)
				}) { (error) in
					self.performRequest = false
					print(error.domain)
			}
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let userListCellPrototype:SearchUserTableViewCell? = {
			let userSearchCell = self.resultTableView.dequeueReusableCellWithIdentifier(self.cellName)
			if userSearchCell is SearchUserTableViewCell{
				return (userSearchCell as! SearchUserTableViewCell)
			}
			return (nil)
		}()
		userListCellPrototype!.loginUser.text = userList[indexPath.row].login
		return (userListCellPrototype!)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.destinationViewController is SearchUserContainerViewController{
			if let userSearch = self.userManager.searchUser{
				self.userManager.currentUser = userSearch
			}
		}
	}
}
