//
//  PostActionButtonsCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 01.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

class PostActionButtonsCell: UITableViewCell {
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            
            likeButton.addTarget(self, action: #selector(likeButtonAction(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeLable: UILabel! {
        didSet {
            likeLable.text = "0"
        }
    }
    @IBOutlet weak var shareLable: UILabel! {
        didSet {
            shareLable.text = "0"
        }
    }
    @IBOutlet weak var commentLable: UILabel! {
        didSet {
            commentLable.text = "0"
        }
    }
    
    
    private var isUserPutLike: Bool = false {
        didSet {
            likeButton.isSelected = isUserPutLike
        }
    }

    
    let cellHeight: CGFloat = 40
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @objc func shareButtonAction(_ sender: UIButton) {
        
    }
    
    func commentButtonAction(_ sender: UIButton) {
        
    }
    
    @objc func likeButtonAction(_ sender: UIButton) {
        var countOfLikes = UInt(likeLable.text ?? "") ?? 0
            
        if isUserPutLike {
            isUserPutLike = false
            countOfLikes -= 1
        } else {
            isUserPutLike = true
            countOfLikes += 1
        }
            
        UIView.transition(with: likeLable,
                          duration: 0.5,
                            options: .transitionFlipFromRight,
                            animations: {
            self.likeLable.text = String(countOfLikes)
        })

    }

}
