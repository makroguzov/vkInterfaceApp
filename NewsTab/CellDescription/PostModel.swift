//
//  PostModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 01.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

protocol CheckData {
    mutating func checkData() -> Bool
}

struct PostModel {
    let postName: String
    let postTime: String
    let postImage: UIImage?
    
    let postText: String
    
    let postImages: [UIImage]
    
    //weak var delegate: PostModelDelegate?
    
    var cellsInSection: [UITableViewCell] = []
}

// MARK: Empty State

extension PostModel {
    static var emptyState: PostModel {
        return PostModel(postName: "", postTime: "", postImage: nil, postText: "", postImages: [])
    }
}

// MARK: Post

extension PostModel {
    func heightForRowAt(_ row: Int) -> CGFloat {
        let cell = cellsInSection[row]
        
        switch cell {
        case is PostActionButtonsCell:
            let cell = cell as! PostActionButtonsCell
            return cell.cellHeight
        
        case is PostDescriptionCell:
            let cell = cell as! PostDescriptionCell
            return cell.cellHeight
        
        case is PostImagesViewCell:
            let cell = cell as! PostImagesViewCell
            return cell.cellHeight
            
        default:
            return 0
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return cellsInSection.count
    }
    
    func cellForRowAt(_ row: Int) -> UITableViewCell {
        return cellsInSection[row]
    }
}
