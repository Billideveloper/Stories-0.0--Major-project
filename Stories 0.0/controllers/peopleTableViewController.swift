//
//  peopleTableViewController.swift
//  Stories 0.0
//
//  Created by Ravi Thakur on 18/02/20.
//  Copyright © 2020 Ravi Thakur. All rights reserved.
//

import UIKit

class peopleTableViewController: UITableViewController, UISearchResultsUpdating {

    
    var users: [User] = []
    
    var searchcontrolelr: UISearchController = UISearchController(searchResultsController: nil)
    
    var searchresults:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchuser()
        navigationbar()
        observeuser()
        
        S.ref.init().dbroot.ref.description()
        S.ref.init().dbuser.ref.description()
        
     

    }
    
    
    func searchuser(){
        searchcontrolelr.searchResultsUpdater = self
        searchcontrolelr.searchBar.placeholder = "Search people"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchcontrolelr
        definesPresentationContext = true
        searchcontrolelr.obscuresBackgroundDuringPresentation = false
    }
    
    func navigationbar(){
        navigationItem.title = "Peoples"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    func  observeuser(){
        Api.User.observeuser { (user) in
            if user.uid != Api.User.currentuserid{
                self.users.append(user)
                self.tableView.reloadData()


            }
    }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty{
            view.endEditing(true)
            
        }else{
            
            let texttype = searchController.searchBar.text!.lowercased()
            filtercontent(for: texttype)
            
        }
        tableView.reloadData()
    }
    
    func filtercontent(for searchtext: String){
        searchresults = self.users.filter {
            return $0.username.lowercased().range(of: searchtext) != nil
        }
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if searchcontrolelr.isActive{
//            return searchresults.count
//        }else{
//        return self.users.count
//        }
//
        return searchcontrolelr.isActive ? searchresults.count: self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: S.peoples.usercellidentifier, for: indexPath) as! usersTableViewCell
        
        
        
        let user = searchcontrolelr.isActive ? searchresults[indexPath.row] : users[indexPath.row]
        cell.loadData(user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as?
            usersTableViewCell{
            
            let storyboard  = UIStoryboard(name: "Main", bundle: nil)
            let chatvc = storyboard.instantiateViewController(identifier: S.chat.chatsceneid) as chatViewController
            chatvc.chatpartner = cell.userprofile.image
            chatvc.partnerusername = cell.username.text
            chatvc.partneruserid = cell.user.uid
            print("partnerid")
            print(chatvc.partneruserid as Any)
            self.navigationController?.pushViewController(chatvc, animated: true)
            
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
