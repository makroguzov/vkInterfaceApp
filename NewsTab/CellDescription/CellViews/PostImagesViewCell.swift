//
//  PostImagesViewCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 01.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

class PostImagesViewCell: UITableViewCell {
    var cellHeight: CGFloat = 0
    private var imageViews: [UIImageView] = []
}

extension PostImagesViewCell {
    struct Data: CheckData {
        var images: [UIImage?]
        var convertImages: [UIImage] = []
        
        mutating func checkData() -> Bool {
            var img = [UIImage]()
            
            for image in images {
                if let image = image {
                    img.append(image)
                }
            }
            
            if img.count == 0 {
                return false
            }

            convertImages = img
            return true
        }
    }

    func updateForModel(data:  PostImagesViewCell.Data) {
        switch data.convertImages.count {
        case 1:
            putOneImage(data.convertImages[0])
        default:
            return
        }
    
    }
    
    private func putOneImage(_ image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        let borderSpacing: CGFloat = (frame.width - image.size.width) / 2
        
        let imageViewConstraints = [
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: borderSpacing),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -borderSpacing),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        addConstraints(imageViewConstraints)
        
        cellHeight = image.size.height
    }
}
