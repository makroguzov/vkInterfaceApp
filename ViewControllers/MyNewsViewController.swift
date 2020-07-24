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

    func customize(_ cell: NewsCell) {
        let contentView = cell.contentView
        
        let postDescriptionViewHeight: CGFloat = 60
        
        let postDescriptionView: UIView = cell.getPostDescriptionViewWith(frame: contentView.bounds, image: nil , name: "группа", time: "10:00")
        contentView.addSubview(postDescriptionView)

        //let footer = cell.getFooter()
        //contentView.addSubview(footer)
        
        postDescriptionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        postDescriptionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        postDescriptionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        postDescriptionView.heightAnchor.constraint(equalToConstant: postDescriptionViewHeight).isActive = true
    
//        let footerHeight: CGFloat = 40
//
//        footer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
//        footer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
//        footer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
//        footer.heightAnchor.constraint(equalToConstant: footerHeight).isActive = true
//        footer.topAnchor.constraint(equalTo: postDescriptionView.bottomAnchor, constant: 60).isActive = true
    }
}

extension MyNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "MyNewsCell") as? NewsCell else {
            fatalError()
        }
        
        customize(newsCell)
        
        return newsCell
    }
}

extension MyNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let cellHeight: CGFloat = 100
            
        return UITableView.automaticDimension
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
