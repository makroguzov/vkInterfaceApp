//
//  Session.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 11.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

class Session {
    
    var token = ""
    var userId = ""
    
    static let shared = Session()
    private init() { }
}
