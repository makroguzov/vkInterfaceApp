//
//  GroupInvitationCellModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 11.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct GroupInvitationCellModel {
    var iventImage: UIImage
    var invitorImage: UIImage
    
    var iventName: String
    var countOfParticipants: String
    var invitorName: String

}

extension GroupInvitationCellModel {
    static var emptyState: GroupInvitationCellModel {
        return GroupInvitationCellModel(iventImage: UIImage(), invitorImage: UIImage(), iventName: "", countOfParticipants: "", invitorName: "")
    }
}
