//
//  MyNewsViewController.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 14.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class MyNewsViewController: UIViewController {
    private let cellSpacingHeight: CGFloat = 8
    private let footerHeigth: CGFloat = 30
    var news: [Int] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = self.view.bounds
        
        tableView.backgroundColor = .lightGray

        tableView.register(NewsCell.self, forCellReuseIdentifier: "MyNewsCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }

}

extension MyNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "MyNewsCell") as? NewsCell else {
//            fatalError()
//        }
        
        let newsCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            return newsCell
        default:
            let footer = NewsFooterControl(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))

            newsCell.contentView.addSubview(footer)
            
            return newsCell
        }
    }
}

extension MyNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .none
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

}
