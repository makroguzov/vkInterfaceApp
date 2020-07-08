//
//  MyGroupsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var myGroups: [Group] = [
        Group(groupName: "1"),
        Group(groupName: "2"),
        Group(groupName: "3"),
        Group(groupName: "4"),
        Group(groupName: "5"),
        Group(groupName: "6"),
        Group(groupName: "7"),
        Group(groupName: "8"),
        Group(groupName: "9"),
        Group(groupName: "10")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let group = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell") as? GroupCell else {
            fatalError()
        }
        
        let currGroup = myGroups[indexPath.row]
        
        group.groupImage?.image = currGroup.image
        group.groupName.text = currGroup.groupName
        
        return group
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    
}
