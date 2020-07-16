//
<<<<<<< HEAD
//  NewsFooterControl.swift
=======
//  NewsFooterCell.swift
>>>>>>> lesson3
//  vkInterfaceApp
//
//  Created by MACUSER on 14.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class NewsFooterControl: UIControl {
=======
class NewsFooterCell: UIControl {
>>>>>>> lesson3
    private var isUserPutLike: Bool = false {
        didSet {
            likeButton.isSelected = isUserPutLike
        }
    }
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    lazy private var likeButton: UIButton = {
        let likeButton = UIButton()
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        likeButton.addTarget(self, action: #selector(likeButtonAction(_ :)), for: .touchUpInside)
        
        likeButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        return likeButton
    }()
    
    lazy private var likeLable: UILabel = {
        let likeLable = UILabel()
        likeLable.text = "12"
        likeLable.adjustsFontForContentSizeCategory = true
        likeLable.translatesAutoresizingMaskIntoConstraints = false
        return likeLable
    }()
    
    lazy private var commentButton: UIButton = {
        let commentButton = UIButton()
        commentButton.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        commentButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        return commentButton
    }()
    
    lazy private var commentLable: UILabel = {
        let commentLable = UILabel()
        commentLable.text = "12"
        commentLable.translatesAutoresizingMaskIntoConstraints = false
        return commentLable
    }()
    
    lazy private var shareButton: UIButton = {
       let shareButton = UIButton()
        shareButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        return shareButton
    }()
    
    @objc func likeButtonAction(_ sender: UIButton) {
        guard var countOfLikes = UInt(likeLable.text ?? "") else {
            return
        }
        
        if isUserPutLike {
            isUserPutLike = false
            countOfLikes -= 1
        } else {
            isUserPutLike = true
            countOfLikes += 1
        }
        
        likeLable.text = String(countOfLikes)
    }
  
<<<<<<< HEAD
=======
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
>>>>>>> lesson3
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //contentView.
        addSubview(stackView)
        
        
        let views: [UIView] = [likeButton, likeLable, commentButton, commentLable, shareButton]
        for view in views {
            stackView.addSubview(view)
        }
        
        self.backgroundColor = .white
        
        putConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }
    
    func putConstraints() {
        let elementSpacing: CGFloat = 40
        let elemeentWithLableSpacing: CGFloat = 5
        
        likeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
        
        
        likeLable.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: elemeentWithLableSpacing).isActive = true
        likeLable.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
        
        commentButton.leftAnchor.constraint(equalTo: likeLable.rightAnchor, constant: elementSpacing).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
        
        commentLable.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: elemeentWithLableSpacing).isActive = true
        commentLable.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
        
        shareButton.leftAnchor.constraint(equalTo: commentLable.rightAnchor, constant: elementSpacing).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor).isActive = true
    }
 }
