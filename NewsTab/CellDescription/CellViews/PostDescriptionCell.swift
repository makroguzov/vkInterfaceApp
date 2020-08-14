//
//  PostDescriptionCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 01.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

class PostDescriptionCell: UITableViewCell {
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.layer.cornerRadius = postImageView.frame.width / 2
            postImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var settingsButton: UIButton!

    let cellHeight: CGFloat = 50
}

extension PostDescriptionCell {
    struct Data: CheckData {
        var postName: String
        var postTime: String
        var postImage: UIImage?

        mutating func checkData() -> Bool {
            if postName == "" || postTime == "" || postImage == nil {
                return false
            }
            
            return true
        }
    }

    func updateForModel(data: PostDescriptionCell.Data) {
        self.postName.text = data.postName
        self.postTime.text = data.postTime
        self.postImageView.image = data.postImage
    }
}
