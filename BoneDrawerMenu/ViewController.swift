//
//  ViewController.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var item: Int?
    var items: [Int]?
    var on: Bool?
    var detail: String?

    var button: UIButton!
    var menu: BoneDrawerMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "BoneDrawerMenu"
        
        self.button = UIButton(frame: CGRect(x: (screen_width - 50) / 2, y: 100, width: 50, height: 50))
        self.button.addTarget(self, action: #selector(action(button:)), for: UIControlEvents.touchUpInside)
        self.button.setTitle("open", for: UIControlState.normal)
        self.button.setTitle("open", for: UIControlState.selected)
        self.button.layer.cornerRadius = self.button.height / 2
        self.button.layer.borderColor = UIColor.orange.cgColor
        self.button.layer.borderWidth = 1
        self.button.setTitleColor(UIColor.orange, for: UIControlState.normal)
        self.view.addSubview(self.button)
        
        self.menu = BoneDrawerMenu()
        self.menu.delegate = self
        self.menu.drawerHeight = 300
        self.menu.titleText = "筛选"
        self.menu.selectColor = UIColor.orange
        self.menu.normalColor = UIColor.lightGray
        self.view.addSubview(self.menu)
    }
    
    func action(button: UIButton) {
        menu.isShow = !menu.isShow
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: BoneDrawerMenuDelegate {
    // 总行数
    func numberOfRows(_ drawerMenu: BoneDrawerMenu) -> Int {
        return 4
    }
    // 设置标题
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, title indexPath: BoneDrawerMenu.indexPath) -> String? {
        if indexPath.row == 0 {
            return "类型"
        } else if indexPath.row == 1 {
            return "排序"
        } else if indexPath.row == 2 {
            return "显示买单"
        }
        return "搜索"
    }
    // 设置类型
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, cellType indexPath: BoneDrawerMenu.indexPath) -> BoneDrawerMenu.CellType {
        if indexPath.row == 0 {
            return .multiSelect
        } else if indexPath.row == 1 {
            return .onlySelect
        } else if indexPath.row == 2 {
            return .switch
        }
        return .text
    }
    // 设置数据源，数据源类型必须与类型对应
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, items indexPath: BoneDrawerMenu.indexPath) -> Any? {
        if indexPath.row == 0 {
            return ["美食", "KTV", "电影院","美食", "KTV", "电影院","美食", "KTV", "电影院"]
        } else if indexPath.row == 1 {
            return ["默认", "从小到大", "从大到小"]
        } else if indexPath.row == 2 {
            return true
        }
        return "我和我的祖国"
    }
    // 设置已选中数据源
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, didSelectItems indexPath: BoneDrawerMenu.indexPath) -> Any? {
        if indexPath.row == 0 {
            return self.items
        } else if indexPath.row == 1 {
            return self.item
        } else if indexPath.row == 2 {
            return self.on
        }
        return self.detail
    }
    
    func cleanData(_ drawerMenu: BoneDrawerMenu) {
        print("清除")
        self.detail = nil
        self.on = nil
        self.items = nil
        self.item = nil
    }
    
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, didSelectRowAt indexPath: BoneDrawerMenu.indexPath) {
        if indexPath.row == 0 {
            print("row--:\(indexPath.row) >>>>>>>>>>>> item--:\(indexPath.items)")
            self.items = indexPath.items
            
        } else if indexPath.row == 1 {
            print("row--:\(indexPath.row) >>>>>>>>>>>> item--:\(indexPath.item)")
            self.item = indexPath.item
            
        } else if indexPath.row == 2 {
            print("row--:\(indexPath.row) >>>>>>>>>>>> on--:\(indexPath.on)")
            self.on = indexPath.on
            
        } else if indexPath.row == 3 {
            print("row--:\(indexPath.row) >>>>>>>>>>>> on--:\(indexPath.detail)")
            self.detail = indexPath.detail
            
            let vc = TwoViewController()
            vc.cellback = { text in
                print("text:\(text)")
                self.detail = text
                drawerMenu.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
