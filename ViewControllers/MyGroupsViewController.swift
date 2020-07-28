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
        return User.curentUser.myGroups
    }()
    private var groupsCells: [Character: [GroupCell]] = [:]
    
    private lazy var titles: [Character] = []
    private lazy var gropsFirstLeterMap: [Character: [Group]] = [:]
    
    private var filteredGroups = [Group]()
    private var searschBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isSearchStarted: Bool {
        return searchController.isActive && !searschBarIsEmpty
    }
    private lazy var searchController: UISearchController = {
        let serchController = UISearchController(searchResultsController: nil)
        
        serchController.searchResultsUpdater = self
        serchController.obscuresBackgroundDuringPresentation = false
        serchController.searchBar.placeholder = "поиск"
        
        return serchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
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
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
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
       
        titles = Array(gropsFirstLeterMap.keys).sorted(by: <)
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearchStarted {
            return 1
        }
        
        return gropsFirstLeterMap.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchStarted {
            return filteredGroups.count
        }
        
        return gropsFirstLeterMap[titles[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let group = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell") as? GroupCell else {
            fatalError()
        }
        
        let currGroup: Group
        
        if isSearchStarted {
            currGroup = filteredGroups[indexPath.row]
        } else {
            guard let sectionGroups = gropsFirstLeterMap[titles[indexPath.section]] else {
                fatalError()
            }
            currGroup = sectionGroups[indexPath.row]
        }
        
        group.groupImage.image = currGroup.image
        group.groupName.text = currGroup.groupName
        
        if groupsCells[titles[indexPath.section]] != nil {
            groupsCells[titles[indexPath.section]]?.append(group)
        } else {
            groupsCells[titles[indexPath.section]] = [group]
        }
        
        return group
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            switch gropsFirstLeterMap[titles[indexPath.section]]?.count {
            case 1:
                gropsFirstLeterMap.removeValue(forKey: titles[indexPath.section])
                groupsCells.removeValue(forKey: titles[indexPath.section])
                titles.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .fade)
            default:
                gropsFirstLeterMap[titles[indexPath.section]]?.remove(at: indexPath.row)
                groupsCells[titles[indexPath.section]]?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = groupsCells[titles[indexPath.section]]?[indexPath.row] else {
            fatalError()
        }
        
        return cell.cellHeight
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

extension MyGroupsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGroups = groupsData.filter({ (group: Group) -> Bool in
            return group.groupName.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
