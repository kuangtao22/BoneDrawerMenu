//
//  BoneDrawerSelectCell.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

extension BoneDrawerSelectCell {
    
    fileprivate var leftSpacing: CGFloat {
        get {
            if let title = self.textLabel?.text {
                if title.isEmpty {
                    return 0
                }
                let width = BoneTools.shared.getTextWidth(text: title, font: UIFont.systemFont(ofSize: 14), height: 15) + 15
                self.scrollView.left = width
                self.scrollView.width = screen_width - width
                return width
            }
            return 0
        }
    }
}

class BoneDrawerSelectCell: UITableViewCell {
    
    /// 圆角
    public var cornerRadius: CGFloat? {
        didSet {
            if let radius = self.cornerRadius {
                for i in 0..<self.itemArray.count {
                    let button = self.scrollView.viewWithTag(i + 100) as? UIButton
                    button?.layer.cornerRadius = radius
                }
            }
        }
    }
    
    /// 选中颜色
    public var selectColor = UIColor.red {
        didSet {
            for i in 0..<self.itemArray.count {
                let button = self.scrollView.viewWithTag(i + 100) as? UIButton
                button?.setTitleColor(self.selectColor, for: UIControlState.selected)
            }
        }
    }
    
    /// 默认颜色
    public var normalColor = UIColor.lightGray {
        didSet {
            for i in 0..<self.itemArray.count {
                let button = self.scrollView.viewWithTag(i + 100) as? UIButton
                button?.setTitleColor(self.normalColor, for: UIControlState.normal)
            }
        }
    }
    
    public var itemArray: [String] = [String]() {
        didSet {
            let spacing: CGFloat = 10
            
            for view in self.scrollView.subviews {
                view.removeFromSuperview()
            }
            var left: CGFloat = spacing
            for i in 0..<self.itemArray.count {
                let buttonWidth = BoneTools.shared.getTextWidth(text: self.itemArray[i], font: UIFont.systemFont(ofSize: 12), height: 12) + 30

                let button = UIButton(frame: CGRect(x: left, y: 15, width: buttonWidth, height: 30))
                button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                button.setTitle(self.itemArray[i], for: UIControlState.normal)
                button.tag = i + 100
                button.layer.cornerRadius = button.height / 2
                button.layer.borderColor = self.normalColor.cgColor
                button.layer.borderWidth = 1
                button.setTitleColor(self.normalColor, for: UIControlState.normal)
                button.setTitleColor(self.selectColor, for: UIControlState.selected)
                button.addTarget(self, action: #selector(action(button:)), for: UIControlEvents.touchUpInside)
                self.scrollView.addSubview(button)
                
                if i == self.itemArray.count - 1 {
                    self.scrollView.contentSize.width = button.right + spacing
                }
                
                left += spacing + buttonWidth
            }
        }
    }

    public var scrollView: UIScrollView!
    
    public var title: String? {
        didSet {
            if let title = self.title {
                self.textLabel?.text = title
                let width = BoneTools.shared.getTextWidth(text: title, font: self.textLabel!.font, height: 15) + 15
                self.scrollView.left = width
                self.scrollView.width = screen_width - width
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        self.textLabel?.textColor = UIColor.darkGray

        self.scrollView = UIScrollView(frame: CGRect(x: self.leftSpacing, y: 0, width: screen_width - self.leftSpacing, height: 60))
        self.contentView.addSubview(self.scrollView)
    }
    
    open func action(button: UIButton) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func tableView(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
