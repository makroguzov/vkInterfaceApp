//
//  PostTextViewCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 01.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import Foundation
import UIKit

class PostTextViewCell: UITableViewCell {
    @IBOutlet weak var heightLayout: NSLayoutConstraint!
}

extension PostTextViewCell {
    func updateForModel(text: String) {
        guard !text.isEmpty else {
            heightLayout.constant = 0
            return
        }
    }
}
