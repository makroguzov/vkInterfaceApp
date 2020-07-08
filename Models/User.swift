//
//  User.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class User{
    static var curentUser = User()
    
    var name: String
    var surname: String
    
    var image: UIImage?
    
    var fullName: String {
        "\(name) \(surname)"
    }
    
    init(name: String, surname: String){
        self.name = name
        self.surname = surname
    }
    
    init() {
        self.name = ""
        self.surname = ""
    }
    
    convenience init(name: String, surname: String, image: UIImage) {
        self.init(name: name, surname: surname)
        
        self.image = image
    }

}
