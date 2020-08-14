//
//  MyFriendsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 13.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyFriendsViewController: UITableViewController {
    private var friendCellModels = [FriendsCellModel]()
    private var friendsAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInitData()
    }
}

extension MyFriendsViewController {
    func getInitData() {
        tableView.beginUpdates()
        getFriends()
    }
    
    func getFriends() {
        NetworkService.shared.loadUserFriends(user_id: Session.shared.userId, order: "hints", list_id: "", count: 2, offset: 0, fields: "photo_200_orig,city,bdate", name_case: "", ref: "") { (friends, friendsAmount) in
            
            let numberOfRows = self.friendCellModels.count
            self.tableView.insertRows(at: Array(numberOfRows ..< numberOfRows + friends.count).map { IndexPath(row: $0, section: 0) }, with: .automatic)

            for friend in friends {
                let model = FriendsCellModel(image: UIImage(data: try! Data(contentsOf: friend.photo_200_orig!)) ?? UIImage(), name: "\(friend.first_name) \(friend.last_name)", subtitle: "")
                self.friendCellModels.append(model)
            }
            
            self.friendsAmount = friendsAmount
            
            
            self.tableView.endUpdates()
            self.tableView.reloadData()
        }
    }
}

extension MyFriendsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendCellModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else {
            fatalError()
        }
        
        cell.model = friendCellModels[indexPath.row]
        
        return cell
    }
    
}
extension MyFriendsViewController {
    
}


