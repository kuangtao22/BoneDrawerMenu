//
//  BoneDrawerOnlyCell.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class BoneDrawerOnlyCell: BoneDrawerSelectCell {
    
    public var type: BoneDrawerMenu.CellType = .onlySelect
    public var cellback: BoneDrawerOnlyCellback?
    
    /// 选中位置
    public var selectNum: Int? {
        didSet {
            if let num = self.selectNum {
                self.selectAction(id: num)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    override func action(button: UIButton) {
        self.selectAction(id: button.tag - 100)
        self.cellback?(button.tag - 100)
        
    }
    
    /// 选中事件
    ///
    /// - Parameter id: 选中ID
    private func selectAction(id: Int) {
        let button = self.scrollView.viewWithTag(id + 100) as? UIButton
        button?.isSelected = true
        button?.layer.borderColor = self.selectColor.cgColor

        for i in 0..<self.itemArray.count {
            if i != id {
                let view = self.scrollView.viewWithTag(i + 100) as? UIButton
                view?.isSelected = false
                view?.layer.borderColor = self.normalColor.cgColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
