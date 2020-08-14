//
//  GroupModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 11.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct GroupModel {
    var imageData: Data
    var groupName: String
    var groupSubtitle: String
}

extension GroupModel {
    static var emptyState: GroupModel {
        return GroupModel(imageData: Data(), groupName: "", groupSubtitle: "")
    }
}

