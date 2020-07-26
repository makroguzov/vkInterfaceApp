//
//  NewsCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 14.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

extension NewsCell {
    struct DescriptionPostData: PostDescriptionData {
        var image: UIImage?
        var name: String
        var postTime: String
    }
}

class NewsCell: UITableViewCell {
    var views: [UIView] = []
    
    func customiseWith(postDescriptionData: PostDescriptionData) {
        let frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 80)
        let postDescriptionView = PostDescriptionView(frame: frame, image: postDescriptionData.image, name: postDescriptionData.name, postTime: postDescriptionData.postTime
        )
        
        contentView.addSubview(postDescriptionView)
        views.append(postDescriptionView)
    }
    
    func customiseWith(postDescriptionData: PostDescriptionData, postText: String) {
        customiseWith(postDescriptionData: postDescriptionData)
        
        //textLabel?.text = postText
    }
    
    func customiseWith(postDescriptionData: PostDescriptionData, postText: String, images: [UIImage?]) {
        customiseWith(postDescriptionData: postDescriptionData, postText: postText)
        
        let imagesFrame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 200)
        let images = ContentImagesView(frame: imagesFrame, images: images)
        
        contentView.addSubview(images)
        views.append(images)
        
        
        
        let footerButtonsFrame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50)
        let footerButtons = FooterButtonsView(frame: footerButtonsFrame)
        
        contentView.addSubview(footerButtons)
        views.append(footerButtons)
    }
    
    func putConstraintsTo() {
        for i in 0..<views.count {
            let view = views[i]
            
            var viewConstraints = [
                view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                view.heightAnchor.constraint(equalToConstant: view.frame.height)
            ]
            
            switch i {
            case 0:
                viewConstraints.append(view.topAnchor.constraint(equalTo: contentView.topAnchor))
            default:
                viewConstraints.append(view.topAnchor.constraint(equalTo: views[i - 1].bottomAnchor))
            }
            
            contentView.addConstraints(viewConstraints)
        }
    }
    
    func clean() {
        views = []
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
}



