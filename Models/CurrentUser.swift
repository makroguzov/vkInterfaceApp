//
//  CurrentUser.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 07.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation

class CurrentUser {
    static var shared = CurrentUser()
    private init() {}
    
    var name: String = ""
    var sureName: String = ""
}
