//
//  Group.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

class Group {
    var groupName: String
    var image: UIImage?
        
    init(groupName: String) {
        self.groupName = groupName
        image = UIImage(systemName: "person")
    }
    
    convenience init(groupName: String, image: UIImage) {
        self.init(groupName: groupName)
    
        self.image = image
    }
}
