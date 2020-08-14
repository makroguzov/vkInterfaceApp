//
//  GroupCellModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 11.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct GroupCellModel {
    var image: UIImage
    var groupName: String
    var groupSubtitle: String
}

extension GroupCellModel {
    static var emptyState: GroupCellModel {
        return GroupCellModel(image: UIImage(), groupName: "", groupSubtitle: "")
    }
}

