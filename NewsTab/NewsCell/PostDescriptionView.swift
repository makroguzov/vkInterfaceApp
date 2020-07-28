//
//  PostDescriptionView.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 25.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

protocol PostDescriptionData {
    var image: UIImage? { get set }
    var name: String { get set }
    var postTime: String { get set }
}

class PostDescriptionView: UIView {
    
    private lazy var imageView: UIImageView = {
        let image: UIImageView = UIImageView()
        
        image.image = UIImage(systemName: "person")
        image.backgroundColor = .white
        image.layer.cornerRadius = frame.height / 2 - 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()

    private lazy var name: UILabel = {
        let groupName = UILabel()
               
        groupName.backgroundColor = .clear
        groupName.textColor = .black
        groupName.translatesAutoresizingMaskIntoConstraints = false
               
        return groupName
    }()
    
    private lazy var postTime: UILabel = {
        let postTime = UILabel()
               
        postTime.backgroundColor = .clear
        postTime.textColor = .lightGray
        postTime.font = UIFont.systemFont(ofSize: 12)
        postTime.translatesAutoresizingMaskIntoConstraints = false
               
        return postTime
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(settingButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, image: UIImage?, name: String, postTime: String) {
        self.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let subviews = [self.imageView, self.name, self.postTime, self.settingsButton]
        addSubviews(subviews)

        self.imageView.image = image
        
        self.name.text = name
        self.postTime.text = postTime
        
        putConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func putConstraints() {
        let elementsSpacing: CGFloat = 10
        
        let settingsButtonSize: CGSize = CGSize(width: 40, height: 40)
        let imageViewSize: CGSize = CGSize(width: frame.height - 2 * elementsSpacing, height: frame.height - 2 * elementsSpacing)
        let lableSize: CGSize = CGSize(width: frame.width - (imageViewSize.width + settingsButtonSize.width + 4 * elementsSpacing), height: frame.height / 2)
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: elementsSpacing),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -elementsSpacing),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: elementsSpacing),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize.width)
        ]
        
        addConstraints(imageViewConstraints)
        
        
        let nameConstraints = [
            name.topAnchor.constraint(equalTo: topAnchor, constant: elementsSpacing),
            name.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: elementsSpacing),
            name.heightAnchor.constraint(equalToConstant: lableSize.height)
        ]
        
        addConstraints(nameConstraints)
        
        
        let postTimeConstraints = [
            postTime.topAnchor.constraint(equalTo: name.bottomAnchor),
            postTime.widthAnchor.constraint(equalTo: name.widthAnchor),
            postTime.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: elementsSpacing),
            postTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -elementsSpacing)
        ]
        
        addConstraints(postTimeConstraints)
        
        
        let settingsButtonConstraints = [
            settingsButton.leftAnchor.constraint(equalTo: name.rightAnchor, constant: elementsSpacing),
            settingsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -elementsSpacing),
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: elementsSpacing),
            settingsButton.heightAnchor.constraint(equalTo: name.heightAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: settingsButtonSize.width)
        ]
        
        addConstraints(settingsButtonConstraints)
    }
    
    private func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    @objc func settingButtonAction(_ sender: UIButton) {
        
    }
}
