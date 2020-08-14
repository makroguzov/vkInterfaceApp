//
//  FriendsCellModel.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 13.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

struct FriendsCellModel {
    var image: UIImage
    var name: String
    var subtitle: String
}

extension FriendsCellModel {
    static var emptyState: FriendsCellModel {
        return FriendsCellModel(image: UIImage(), name: "", subtitle: "")
    }
}
