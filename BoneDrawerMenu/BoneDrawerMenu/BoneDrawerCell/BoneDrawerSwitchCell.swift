//
//  BoneDrawerSwitchCell.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class BoneDrawerCell: UITableViewCell {
    
    static var getHeight: CGFloat = 50

    public var on: Bool {
        get {
            return self.switchBtn.isOn
        }
        set {
            self.switchBtn.setOn(newValue, animated: true)
        }
    }
    
    public var cellback: BoneDrawerSwitchCellback?
    
    public var switchBtn: UISwitch!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        self.textLabel?.textColor = UIColor.darkGray
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        self.detailTextLabel?.textColor = UIColor.lightGray
        
        self.switchBtn = UISwitch()
        self.switchBtn.isHidden = true
        self.switchBtn.centerY = BoneDrawerCell.getHeight / 2
        self.switchBtn.right = screen_width - 15
        self.switchBtn.addTarget(self, action: #selector(BoneDrawerCell.action(button:)), for: UIControlEvents.valueChanged)
        self.contentView.addSubview(self.switchBtn)
    }
    
    @objc private func action(button: UISwitch) {
        self.cellback?(button.isOn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
