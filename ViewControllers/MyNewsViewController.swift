//
//  MyNewsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 14.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyNewsViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.view.bounds
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension MyNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension MyNewsViewController: UITableViewDelegate {
    
}
