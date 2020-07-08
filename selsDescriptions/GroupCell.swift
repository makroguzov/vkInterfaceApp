//
//  GroupCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView?

    override func awakeFromNib() {
        groupImage?.backgroundColor = .black
        groupImage?.layer.cornerRadius = 40
    }
    
}
