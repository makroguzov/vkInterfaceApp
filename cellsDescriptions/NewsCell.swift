//
//  NewsCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 14.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
        
    /// MARK footer (likebutton etc.)
    lazy private var footerView: UIView = {
        let footerView = UIView()
           
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        return footerView
    }()
    
    lazy private var likeButton: UIButton = {
        let likeButton = UIButton()
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        
        likeButton.addTarget(self, action: #selector(likeButtonAction(_ :)), for: .touchUpInside)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        return likeButton
    }()
       
    lazy private var likeLable: UILabel = {
        let likeLable = UILabel()
        likeLable.text = "12"
        
        
        likeLable.translatesAutoresizingMaskIntoConstraints = false
        return likeLable
    }()
       
    lazy private var commentButton: UIButton = {
        let commentButton = UIButton()
        commentButton.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        
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
    
    private var isUserPutLike: Bool = false {
        didSet {
            likeButton.isSelected = isUserPutLike
        }
    }
            
    private func putFooterConstraints() {
        
        let buttonButtonSpacing: CGFloat = 30
        let buttonLableSpacing: CGFloat = 10

        
        likeButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 10).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: self.footerView.centerYAnchor).isActive = true

        
        likeLable.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: buttonLableSpacing).isActive = true
        likeLable.centerYAnchor.constraint(equalTo: self.footerView.centerYAnchor).isActive = true
        
        
        commentButton.leftAnchor.constraint(equalTo: likeLable.rightAnchor, constant: buttonButtonSpacing).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: self.footerView.centerYAnchor).isActive = true
        
        
        commentLable.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: buttonLableSpacing).isActive = true
        commentLable.centerYAnchor.constraint(equalTo: self.footerView.centerYAnchor).isActive = true

        
        shareButton.leftAnchor.constraint(equalTo: commentLable.rightAnchor, constant: buttonButtonSpacing).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: self.footerView.centerYAnchor).isActive = true
    }

    func getFooter() -> UIView {
        let views: [UIView] = [likeButton, likeLable, commentButton, commentLable, shareButton]
        for view in views {
            footerView.addSubview(view)
        }
        
        putFooterConstraints()
        
        footerView.backgroundColor = .white
        
        return footerView
    }

    /// MARK imagess
    
    private lazy var imagesView: UIView = {
        let imagesView = UIView()
    
        return imagesView
    }()
    
    func putToImagesView(images: [UIImage]) {
        for image in images {
            let imageView = UIImageView()
            imageView.image = image
            
            putConstraintsFor(imageView: imageView)
            
            imagesView.addSubview(imageView)
        }
    }
    
    private func putConstraintsFor(imageView: UIImageView) {
        
    }
    
    /// MARK header with goup name
    private lazy var postDescriptionView: UIView = {
        let headerView = UIView()
                
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    private lazy var groupImage: UIImageView = {
        let groupImage: UIImageView = UIImageView()
        
        groupImage.image = UIImage(systemName: "person")
        groupImage.backgroundColor = .white
        
        return groupImage
    }()

    private lazy var groupName: UILabel = {
        let groupName = UILabel()
               
        groupName.backgroundColor = .clear
        groupName.textColor = .black
        groupName.translatesAutoresizingMaskIntoConstraints = false
               
        return groupName
    }()
    
    private lazy var postTime: UILabel = {
        let postTime = UILabel()
               
        postTime.backgroundColor = .clear
        postTime.textColor = .black
        postTime.translatesAutoresizingMaskIntoConstraints = false
               
        return postTime
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(settingButtonAction(_:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc func settingButtonAction(_ sender: UIButton) {
        
    }
    
    func getPostDescriptionViewWith(frame: CGRect, image: UIImage?, name: String, time: String) -> UIView {
        
        groupImage.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        
        if let image = image {
            groupImage.image = image
        }
        groupImage.layer.cornerRadius = frame.size.width / 2
        
        postDescriptionView.addSubview(groupImage)
        
        
        
        //
        //settingsButton.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        postDescriptionView.addSubview(settingsButton)

        settingsButton.centerYAnchor.constraint(equalTo: postDescriptionView.centerYAnchor).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: postDescriptionView.rightAnchor, constant: 0).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        //settingsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
      
        
        //
        groupName.text = name
        postDescriptionView.addSubview(groupName)
        
        groupName.rightAnchor.constraint(equalTo: groupImage.rightAnchor, constant: 0).isActive = true
        groupName.leftAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: 0).isActive = true
        groupName.topAnchor.constraint(equalTo: postDescriptionView.topAnchor, constant: 0).isActive = true
        groupName.heightAnchor.constraint(equalToConstant: frame.height / 2).isActive = true

        
        //
        postTime.text = time
        postDescriptionView.addSubview(postTime)

        postTime.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 0).isActive = true
        postTime.leftAnchor.constraint(equalTo: groupImage.rightAnchor, constant: 0).isActive = true
        postTime.rightAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: 0).isActive = true
        postTime.bottomAnchor.constraint(equalTo: postDescriptionView.bottomAnchor, constant: 0).isActive = true
    
        
        return postDescriptionView
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



