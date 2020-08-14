//
//  UserModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

extension UserModel {
    enum Deactivated {
        case none,deleted
    }
}

struct UserModel {
    let id: Int
    
    var deactivated: Deactivated = .none
    
    var can_access_closed: Int = 0
    var is_closed: Int = 0
    
    let first_name: String
    let last_name: String
    
    var bdate: String = ""
    var city: String = ""
    
    var photo_100: URL?
    var photo_200: URL?
    var photo_50: URL?
    var photo_200_orig: URL?
}

extension UserModel {
    init(json: [String: Any]) {
        id = json["id"] as! Int

        first_name = json["first_name"] as! String
        last_name = json["last_name"] as! String

        if let _ = json["can_access_closed"] {
            self.deactivated = .deleted
        }
        
        
        if let can_access_closed = json["can_access_closed"] {
            self.can_access_closed = can_access_closed as! Int
        }
        if let is_closed = json["is_closed"] {
            self.is_closed = is_closed as! Int
        }

        
        
        if let photo_200 = json["photo_200"] {
            self.photo_200 = URL(string: photo_200 as! String)!
        }
        if let photo_100 = json["photo_100"] {
            self.photo_100 = URL(string: photo_100 as! String)!
        }
        if let photo_50 = json["photo_50"] {
            self.photo_50 = URL(string: photo_50 as! String)!
        }
        if let photo_200_orig = json["photo_200_orig"] {
            self.photo_200_orig = URL(string: photo_200_orig as! String)!
        }
        
        
        if let bdate = json["bdate"] {
            self.bdate = bdate as! String
        }
        
        
//        if let city = json["city"] {
//            self.city = city as! String
//        }
    }
}

