//
//  NewsCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 14.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    func addFooter(frame: CGRect) {
        let footer = FooterControl(frame: frame)
        addSubview(footer)
    }
}



