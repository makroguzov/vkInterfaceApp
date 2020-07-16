//
//  GroupCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

//почему не менятеся размер contentView. И как его изменить
//как пересчитать  var baseView: UIView =. Это высчитывается только 1 раз?
//почему не работает метод обновления констраинтов
//если убрал frame (groupName.translatesAutoresizingMaskIntoConstraints = false) как узать размеры экрана (ячейки)

class GroupCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        
        baseView.backgroundColor = UIColor.clear
        
        baseView.layer.shadowColor = UIColor.yellow.cgColor
        baseView.layer.shadowOffset = CGSize(width: 3, height: 3)
        baseView.layer.shadowOpacity = 0.7
        baseView.layer.shadowRadius = 6
        
        return baseView
    }()
    
    lazy var borderView: UIView = {
        let borderView = UIView()
        
        borderView.layer.borderColor = UIColor.green.cgColor
        borderView.layer.borderWidth = 3
        borderView.layer.masksToBounds = true
        
        return borderView
    }()
    
    lazy var groupName: UILabel = {
        let groupName = UILabel()
        
        groupName.backgroundColor = .clear
        groupName.textColor = .green
        groupName.translatesAutoresizingMaskIntoConstraints = false
        
        return groupName
    }()
    
    lazy var groupImage: UIImageView = {
        let groupImage: UIImageView = UIImageView()
        groupImage.image = UIImage(named: "person")
        groupImage.backgroundColor = .white
        return groupImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func createViews() {
        let borderSpacing: CGFloat = 10
        
        baseView.frame = CGRect(x: borderSpacing, y: borderSpacing, width: 80, height: 80)
        contentView.addSubview(baseView)

        borderView.frame = baseView.bounds
        borderView.layer.cornerRadius = borderView.frame.size.width / 2
        baseView.addSubview(borderView)

        groupImage.frame = borderView.bounds
        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
        borderView.addSubview(groupImage)

        addSubview(groupName)
        groupName.topAnchor.constraint(equalTo: self.topAnchor, constant: borderSpacing).isActive = true
        groupName.leftAnchor.constraint(equalTo: baseView.rightAnchor, constant: borderSpacing).isActive = true
        groupName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -borderSpacing).isActive = true
        groupName.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
