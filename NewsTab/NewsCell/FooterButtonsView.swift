//
//  FooterButtonsView.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 26.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class FooterButtonsView: UIView {
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
        
        UIView.transition(with: likeLable,
                          duration: 1,
                          options: .transitionFlipFromRight,
                          animations: {
            self.likeLable.text = String(countOfLikes)
        })
    }
    
    private var isUserPutLike: Bool = false {
        didSet {
            likeButton.isSelected = isUserPutLike
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        translatesAutoresizingMaskIntoConstraints = false
        
        let views = [likeButton, likeLable, commentButton, commentLable, shareButton]
        addSubviews(views)
        
        backgroundColor = .white
        
        putConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func putConstraints() {
        let buttonButtonSpacing: CGFloat = 30
        let buttonLableSpacing: CGFloat = 10

        
        likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        likeLable.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: buttonLableSpacing).isActive = true
        likeLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        commentButton.leftAnchor.constraint(equalTo: likeLable.rightAnchor, constant: buttonButtonSpacing).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        commentLable.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: buttonLableSpacing).isActive = true
        commentLable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
        shareButton.leftAnchor.constraint(equalTo: commentLable.rightAnchor, constant: buttonButtonSpacing).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
