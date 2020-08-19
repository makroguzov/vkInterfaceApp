//
//  MyGroupsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var cellGroupModels = [GroupCellModel]()
    private var totalGroupsCount: Int = 0
    private var offset: Int = 0
    
    private var cellGroupInvitationModels = [GroupInvitationCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInitData()
    }
}

extension MyGroupsViewController {
    func getInitData() {
        getGroups(count: 100)
        //loadUserGroupInvitations()
    }
    
    func getGroups(count: Int){
        NetworkService.shared.loadUserGroups(userId: Session.shared.userId, extended: 1, filter: "", fields: "", offset: 0, count: count) { (userGroupModel) in
            self.tableView.beginUpdates()
            
            let totalGroupsCount = userGroupModel.response.count
            let groups = userGroupModel.response.groups
            
            let numberOfRows = self.cellGroupModels.count
            self.tableView.insertRows(at: Array(numberOfRows ..< numberOfRows + groups.count).map { IndexPath(row: $0, section: 1) }, with: .automatic)

            
            for group in groups {
                let groupCellModel = GroupCellModel(image: group.photo_200, groupName: group.name, groupSubtitle: group.screen_name)
                self.cellGroupModels.append(groupCellModel)
            }
            self.totalGroupsCount = totalGroupsCount

            self.offset += count
            
            self.tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
    
    func getFilteredGroups() {
        
    }
    
    func loadUserGroupInvitations() {
        NetworkService.shared.loadUserGroupInvitations(offset: 0, count: 2, extended: 1) { (userGroupInvitationModel) in
            self.tableView.beginUpdates()
            
            let events = userGroupInvitationModel.response.events
            let invitorGroups: [Int: [GroupModel]] = Dictionary(grouping: userGroupInvitationModel.response.invitorGroups) { $0.id }
            let invitorUsers: [Int: [UserModel]] =  Dictionary(grouping: userGroupInvitationModel.response.invitorUsers) { $0.id }
        
            for event in events {
                if let invitor = invitorGroups[abs(event.is_advertiser)]{
                    let invitor = invitor[0]
                    let groupInvitationCell = GroupInvitationCellModel(eventImage: event.photo_200, invitorImage: "", eventName: event.name, countOfParticipants: "", invitorName: invitor.name)
                    self.cellGroupInvitationModels.append(groupInvitationCell)
                } else if let invitor = invitorUsers[event.is_advertiser] {
                    let invitor = invitor[0]
                    let groupInvitationCell = GroupInvitationCellModel(eventImage: event.photo_200, invitorImage: "", eventName: event.name, countOfParticipants: "", invitorName: invitor.last_name)
                    self.cellGroupInvitationModels.append(groupInvitationCell)
                }
            }
            
            self.tableView.reloadData()
            self.tableView.endUpdates()
        }
    }
}

extension MyGroupsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Все сообщества \(totalGroupsCount)"
        default:
            return "Приглашения"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return cellGroupModels.count
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupCell else {
                fatalError()
            }
            
            cell.model = cellGroupModels[indexPath.row]
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupInvitationCell") as? GroupInvitationCell else {
                fatalError()
            }
            
            cell.model =  .emptyState //cellGroupInvitationModels[indexPath.row]
            
            return cell
        }
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 ? 70 : 110
    }
    
}




//    private var isRowSelected: Bool = false
//
//    private lazy var groupsData: [Group] = {
//        return User.curentUser.myGroups
//    }()
//    private var groupsCells: [Character: [GroupCell]] = [:]
//
//    private lazy var titles: [Character] = []
//    private lazy var gropsFirstLeterMap: [Character: [Group]] = [:]
//
//    private var filteredGroups = [Group]()
//    private var searschBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//    private var isSearchStarted: Bool {
//        return searchController.isActive && !searschBarIsEmpty
//    }
//    private lazy var searchController: UISearchController = {
//        let serchController = UISearchController(searchResultsController: nil)
//
//        serchController.searchResultsUpdater = self
//        serchController.obscuresBackgroundDuringPresentation = false
//        serchController.searchBar.placeholder = "поиск"
//
//        return serchController
//    }()
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//
//        tableView.frame = view.frame
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.rowHeight = 100
//        tableView.register(GroupCell.self, forCellReuseIdentifier: "MyGroupCell")
//
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        createGropsFirstLeterMap()
//
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//
//        view.addSubview(tableView)
//    }
//
//    private func createGropsFirstLeterMap(){
//        for group in groupsData {
//            guard let firstLetter = group.groupName.first else {
//                continue
//            }
//
//            if gropsFirstLeterMap[firstLetter] != nil {
//                gropsFirstLeterMap[firstLetter]?.append(group)
//            } else {
//                gropsFirstLeterMap[firstLetter] = [group]
//            }
//        }
//
//        titles = Array(gropsFirstLeterMap.keys).sorted(by: <)
//    }
//}
//
//extension MyGroupsViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if isSearchStarted {
//            return 1
//        }
//
//        return gropsFirstLeterMap.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isSearchStarted {
//            return filteredGroups.count
//        }
//
//        return gropsFirstLeterMap[titles[section]]?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let group = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell") as? GroupCell else {
//            fatalError()
//        }
//
//        let currGroup: Group
//
//        if isSearchStarted {
//            currGroup = filteredGroups[indexPath.row]
//        } else {
//            guard let sectionGroups = gropsFirstLeterMap[titles[indexPath.section]] else {
//                fatalError()
//            }
//            currGroup = sectionGroups[indexPath.row]
//        }
//
////        group.groupImage.image = currGroup.image
////        group.groupName.text = currGroup.groupName
//
//        if groupsCells[titles[indexPath.section]] != nil {
//            groupsCells[titles[indexPath.section]]?.append(group)
//        } else {
//            groupsCells[titles[indexPath.section]] = [group]
//        }
//
//        return group
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            switch gropsFirstLeterMap[titles[indexPath.section]]?.count {
//            case 1:
//                gropsFirstLeterMap.removeValue(forKey: titles[indexPath.section])
//                groupsCells.removeValue(forKey: titles[indexPath.section])
//                titles.remove(at: indexPath.section)
//                tableView.deleteSections([indexPath.section], with: .fade)
//            default:
//                gropsFirstLeterMap[titles[indexPath.section]]?.remove(at: indexPath.row)
//                groupsCells[titles[indexPath.section]]?.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let cell = groupsCells[titles[indexPath.section]]?[indexPath.row] else {
//            fatalError()
//        }
//
//        return 10 //cell.cellHeight
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return String(titles[section])
//    }
//
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return titles.map{ String($0) }
//    }
//}
//
//extension MyGroupsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}
//
//extension MyGroupsViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    private func filterContentForSearchText(_ searchText: String) {
//        filteredGroups = groupsData.filter({ (group: Group) -> Bool in
//            return group.groupName.lowercased().contains(searchText.lowercased())
//        })
//
//        tableView.reloadData()
//    }
//}
