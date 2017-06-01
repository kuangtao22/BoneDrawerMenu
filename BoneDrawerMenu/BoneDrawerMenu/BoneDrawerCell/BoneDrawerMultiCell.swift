//
//  BoneDrawerMultiCell.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class BoneDrawerMultiCell: BoneDrawerSelectCell {
    
    public var ids: [Int] = [Int]() {
        didSet {
            for i in 0..<self.itemArray.count {
                let button = self.scrollView.viewWithTag(i + 100) as? UIButton
                let ishave = self.ids.contains(i)
                button?.isSelected = ishave
                let color = ishave ? self.selectColor : self.normalColor
                button?.layer.borderColor = color.cgColor
            }
        }
    }
    
    private var mulitArray: NSMutableArray!
    public var cellback: BoneDrawerMultiCellback?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mulitArray = NSMutableArray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func action(button: UIButton) {
        button.isSelected = !button.isSelected
        let color = button.isSelected ? self.selectColor : self.normalColor
        button.layer.borderColor = color.cgColor
        
        if button.isSelected {
            self.mulitArray.add(button.tag - 100)
        } else {
            self.mulitArray.remove(button.tag - 100)
        }
        
        var items: [Int] = [Int]()
        for id in self.mulitArray {
            items.append(id as! Int)
        }
        self.cellback?(items)
    }

    
}
