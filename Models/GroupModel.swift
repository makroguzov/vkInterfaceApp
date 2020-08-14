//
//  GroupModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct GroupModel {
    let id: Int
    
    let is_admin: Int
    let is_advertiser: Int
    let is_closed: Int
    let is_member: Int
    
    let name: String
    let screen_name: String

    let photo_100: URL
    let photo_200: URL
    let photo_50: URL
    
    let type: String
}

extension GroupModel {
    init(json: [String: Any]) {
        id = json["id"] as! Int
        
        is_admin = json["is_admin"] as! Int
        is_advertiser = json["is_advertiser"] as! Int
        is_closed = json["is_closed"] as! Int
        is_member = json["is_member"] as! Int
        
        name = json["name"] as! String
        screen_name = json["screen_name"] as! String
                
        photo_200 = URL(string: json["photo_200"] as! String)!
        photo_100 = URL(string: json["photo_100"] as! String)!
        photo_50 = URL(string: json["photo_50"] as! String)!
        
        type = json["type"] as! String
    }
}
