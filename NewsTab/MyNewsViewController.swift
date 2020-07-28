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
    
    var newsData: [Int] = []
    var news: [NewsCell] = []
        
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
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "MyNewsCell") as? NewsCell else {
            fatalError()
        }
        
        if indexPath.section < news.count {
            return news[indexPath.section]
        }
                
        let postText = "qweweff"
        let images = [UIImage(named: "vk_logo")]
        let postDescriptionDate = NewsCell.DescriptionPostData(image: UIImage(named: "vk_logo"), name: "sdkjfnlkjf", postTime: "12:00")
        
        
        newsCell.clean()
        newsCell.customiseWith(postDescriptionData: postDescriptionDate, postText: postText, images: images)
        newsCell.putConstraintsTo()
        
        news.append(newsCell)
        
        return newsCell
    }
}

extension MyNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViews = news[indexPath.section].contentView.subviews
        let rowHeight = cellViews.reduce(0){
            $0 + $1.frame.height
        }
        
        return rowHeight 
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
