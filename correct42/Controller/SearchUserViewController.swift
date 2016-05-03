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
	let cellName = "searchUserCell"
	var userList = [User]()
	var searchingState = false
	
	
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
    }
	
	//MARK: - Other methods
	func searchValueOnAPI(value:String){
		if (searchingState == false && value != ""){
			searchingState = true
			userManager.fetchSearchUser(value, success: { (fetchedListUser) in
					self.userList = fetchedListUser
					self.resultTableView.reloadData()
					self.searchingState = false
				}) { (error) in
					print(error.domain)
					self.searchingState = false
				}
		} else if value == "" {
			self.userList.removeAll()
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
		userManager.fetchUserById(userList[indexPath.row].id, success: { (user) in
				self.userManager.currentUser = self.userManager.searchUser
				self.performSegueWithIdentifier("goToUserSearch", sender: self)
			}) { (error) in
				print(error.domain)
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
	
}
