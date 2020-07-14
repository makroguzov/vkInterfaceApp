//
//  MyGroupsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)    
        self.tableView.register(GroupCell.self, forCellReuseIdentifier: "MyGroupCell")
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
            
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.curentUser.myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let group = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell") as? GroupCell else {
            fatalError()
        }
        
        let currGroup = User.curentUser.myGroups[indexPath.row]
        
        group.groupImage.image = currGroup.image
        group.groupName.text = currGroup.groupName
        
        return group
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            User.curentUser.myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let group = tableView.cellForRow(at: indexPath) as? GroupCell else {
            fatalError()
        }
        
        if group.isSelected {
            group.groupImage.backgroundColor = .black
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        }
    
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let group = tableView.cellForRow(at: indexPath) as? GroupCell else {
            fatalError()
        }
        group.groupImage.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let group = tableView.cellForRow(at: indexPath) as? GroupCell else {
            fatalError()
        }
        group.groupImage.backgroundColor = .black
    }
}
