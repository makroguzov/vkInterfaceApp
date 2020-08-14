//
//  testTable.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 13.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class testTable: UITableViewCell {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension testTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell else {
            fatalError()
        }
        
        cell.model = .emptyState
        
        return cell
    }
}

extension testTable: UITableViewDelegate {
    
}
