//
//  ContentImagesView.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 26.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class ContentImagesView: UIView {
    private var imagViews: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, images: [UIImage?]) {
        self.init(frame: frame)
        
        for image in images {
            let imageView = UIImageView()
    
            imageView.image = image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(imageView)
            imagViews.append(imageView)
        }
        
        putConstraints()
    }
    
    func putConstraints() {
        let numberOfImageViews = imagViews.count
        
        switch numberOfImageViews {
        case 1:
            putConstraintsForOneImageView()
        default:
            return
        }
        
    }
    
    private func putConstraintsForOneImageView() {
        guard let imageView = imagViews.first else { return }
        
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: frame.height),
            imageView.widthAnchor.constraint(equalToConstant: frame.width)
        ]
        
        addConstraints(constraints)
    }
}
