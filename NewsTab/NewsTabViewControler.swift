//
//  NewsTabViewControler.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 01.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

class NewsTabViewControler: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var cellModels = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModels = [
            PostModel(postName: "qwe", postTime: "123", postImage: UIImage(named: "vk_logo"), postText: "ejfs;aldksfjl;sakdn", postImages: [])
        ]
        
        fillInTableWith(posts: [Post(), Post(), Post(), Post(), Post(), Post(), Post(), Post()])
        
        
        setTableViewParametrs()
    }
    
    private func setTableViewParametrs() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
    
    }
}

extension NewsTabViewControler: UITableViewDelegate {
    
}

extension NewsTabViewControler: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels[section].numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellModels[indexPath.section].cellForRowAt(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellModels[indexPath.section].heightForRowAt(indexPath.row)
    }
}

extension NewsTabViewControler {

    func fillInTableWith(posts: [Post]) {
        for post in posts {
            let postModel = fillInPostModel(with: post)
            cellModels.append(postModel)
        }
        
    }
    
    private func fillInPostModel(with: Post) -> PostModel {
        var postModel: PostModel = .emptyState
                
        guard let postDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "PostDescriptionCell") as? PostDescriptionCell else {
            fatalError("Could not dequeue reusable cell 'PostDescriptionCell'")
        }
        
        var postDescriptionCellData = PostDescriptionCell.Data(postName: "qwe", postTime: "123", postImage: UIImage(named: "vk_logo"))
        if  postDescriptionCellData.checkData() {
            postDescriptionCell.updateForModel(data: postDescriptionCellData)
            postModel.cellsInSection.append(postDescriptionCell)
        }
        
        
        
        
        guard let postImagesViewCell = tableView.dequeueReusableCell(withIdentifier: "PostImagesViewCell") as? PostImagesViewCell else {
            fatalError("Could not dequeue reusable cell 'PostImagesViewCell'")
        }
        
        var postImagesViewCellData = PostImagesViewCell.Data(images: [UIImage(named: "vk_logo")])
        if postImagesViewCellData.checkData() {
            postImagesViewCell.updateForModel(data: postImagesViewCellData)
            postModel.cellsInSection.append(postImagesViewCell)
        }
        
        
        
        guard let postActionButtonsCell = tableView.dequeueReusableCell(withIdentifier: "PostActionButtonsCell") as? PostActionButtonsCell else {
            fatalError("Could not dequeue reusable cell 'PostDescriptionCell'")
        }
        postModel.cellsInSection.append(postActionButtonsCell)

        return postModel
    }
}

