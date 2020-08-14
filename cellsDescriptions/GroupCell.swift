//
//  GroupCell.swift
//  vkInterfaceApp
//
//  Created by MACUSER on 08.07.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupImageView: UIImageView! {
        didSet {
            groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        }
    }
    @IBOutlet weak var groupNameLable: UILabel!
    @IBOutlet weak var groupSubTitleLable: UILabel!
    
    var model: GroupCellModel = .emptyState {
        didSet{
            groupImageView.image = model.image
            groupNameLable.text = model.groupName
            groupSubTitleLable.text = model.groupSubtitle
        }
    }
}

//    var cellHeight: CGFloat = 0
//
//    lazy var baseView: UIView = {
//        let baseView = UIView()
//
//        baseView.backgroundColor = UIColor.clear
//
//        baseView.layer.shadowColor = UIColor.black.cgColor
//        baseView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        baseView.layer.shadowOpacity = 0.7
//        baseView.layer.shadowRadius = 6
//
//        return baseView
//    }()
//
//    lazy var groupName: UILabel = {
//        let groupName = UILabel()
//
//        groupName.backgroundColor = .clear
//        groupName.textColor = .green
//        groupName.translatesAutoresizingMaskIntoConstraints = false
//
//        return groupName
//    }()
//
//    lazy var groupImage: UIImageView = {
//        let groupImage: UIImageView = UIImageView()
//        groupImage.image = UIImage(named: "person")
//        groupImage.backgroundColor = .white
//        groupImage.layer.masksToBounds = true
//
//
//        let tapGesrure: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateTapGesture))
//        groupImage.addGestureRecognizer(tapGesrure)
//
//        groupImage.isUserInteractionEnabled = true
//
//
//        return groupImage
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        createViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func createViews() {
//        let borderSpacing: CGFloat = 10
//
//        baseView.frame = CGRect(x: borderSpacing, y: borderSpacing, width: 60, height: 60)
//        contentView.addSubview(baseView)
//
//        groupImage.frame = baseView.bounds
//        groupImage.layer.cornerRadius = groupImage.frame.size.width / 2
//        baseView.addSubview(groupImage)
//
//        addSubview(groupName)
//        groupName.topAnchor.constraint(equalTo: self.topAnchor, constant: borderSpacing).isActive = true
//        groupName.leftAnchor.constraint(equalTo: baseView.rightAnchor, constant: borderSpacing).isActive = true
//        groupName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -borderSpacing).isActive = true
//        groupName.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        cellHeight = baseView.frame.height + 2 * borderSpacing
//    }
//
//    @objc private func animateTapGesture() {
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.fromValue =  1
//        animation.toValue = 0.9
//        animation.duration = 0.1
//        animation.fillMode = .removed
//
//        self.baseView.layer.add(animation, forKey: nil)
//    }

