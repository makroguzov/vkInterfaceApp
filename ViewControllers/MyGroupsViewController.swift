//
//  MyGroupsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {
    private var isRowSelected: Bool = false
    
    private lazy var groupsData: [Group] = {
        let groups = User.curentUser.myGroups
        return groups
    }()
    
    private lazy var titles: [Character] = []
    private lazy var gropsFirstLeterMap: [Character: [Group]] = [:]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        tableView.register(GroupCell.self, forCellReuseIdentifier: "MyGroupCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGropsFirstLeterMap()
        
        view.addSubview(tableView)
    }
    
    private func createGropsFirstLeterMap(){
        for group in groupsData {
            guard let firstLetter = group.groupName.first else {
                continue
            }
            
            if gropsFirstLeterMap[firstLetter] != nil {
                gropsFirstLeterMap[firstLetter]?.append(group)
            } else {
                gropsFirstLeterMap[firstLetter] = [group]
            }
        }
       
        titles = Array(gropsFirstLeterMap.keys)
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return gropsFirstLeterMap.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gropsFirstLeterMap[titles[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let group = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell") as? GroupCell else {
            fatalError()
        }
        
        guard let sectionGroups = gropsFirstLeterMap[titles[indexPath.section]] else {
            fatalError()
        }
        
        let currGroup = sectionGroups[indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(titles[section])
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titles.map{ String($0) }
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
