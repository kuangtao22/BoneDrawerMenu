//
//  BoneDrawerMenu.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

extension BoneDrawerMenu {

    /// 表格源类型
    ///
    /// - multiSelect: 多选
    /// - onlySelect: 单选
    /// - `switch`: 开关
    /// - text: 文本
    enum CellType {
        case multiSelect
        case onlySelect
        case `switch`
        case text
    }
    
    /// 是否显示
    public var isShow: Bool {
        get {
            return self.show
        }
        set {
            self.show = newValue
            if self.show {
                self.showAnimate()
            } else {
                self.hideAnimate()
            }
        }
    }
    
    /// 标题
    public var titleText: String {
        get { return self.titleLabel.text ?? "" }
        set { self.titleLabel.text = newValue }
    }
    
    /// 控件总高度
    public var drawerHeight: CGFloat{
        get {
            return self.height
        }
        set {
            self.menuView.height = newValue
            self.lineView.top = 0
            self.titleLabel.top = 0
            self.tableView.top = self.titleLabel.bottom
            self.tableView.height = self.height - self.titleLabel.bottom
        }
    }
    
    /// 重置TODO
    public func reloadData() {
        for view in self.menuView.subviews {
            if let table = view as? UITableView {
                table.removeFromSuperview()
            }
        }
        self.tableView = self.getTableView()
        self.menuView.addSubview(self.tableView)
        self.tableView.reloadData()
    }
    
    public func cleanSelect() {
        self.tableView.reloadData()
        self.delegate?.cleanData(self)
    }
}

class BoneDrawerMenu: UIView {
    
    /// 选中颜色
    public var selectColor: UIColor = UIColor.red {
        didSet {
            let icon = self.cleanBtn.imageView?.image?.color(to: self.selectColor)
            self.cleanBtn.setImage(icon, for: UIControlState.normal)
            self.tableView.reloadData()
        }
    }
    
    /// 默认颜色
    public var normalColor: UIColor = UIColor.lightGray {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    class indexPath {
        var row = 0
        var item = 0
        var items = [Int]()
        var on = false
        var detail = ""
    }
    /// 代理
    public var delegate: BoneDrawerMenuDelegate?

    /// 标题控件
    fileprivate var titleLabel: UILabel!
    /// 动画时间
    fileprivate var interval: TimeInterval = 0.2
    /// 是否显示
    fileprivate var show: Bool = false
    /// 顶部边线
    fileprivate var lineView: UIView!
    /// 清除按钮
    fileprivate lazy var cleanBtn: UIButton = {
        let x = screen_width - self.closeBtn.width - 40
        let cleanBtn = UIButton(frame: CGRect(x: x, y: 0, width: 40, height: self.titleLabel.height))
        cleanBtn.addTarget(self, action: #selector(cleanSelect), for: UIControlEvents.touchUpInside)
        let icon = UIImage(named: "IconBoneDrawer.bundle/clean")?.color(to: self.selectColor)
        cleanBtn.setImage(icon, for: UIControlState.normal)
        return cleanBtn
    }()
    /// 关闭按钮
    fileprivate lazy var closeBtn: UIButton = {
        let closeBtn = UIButton(frame: CGRect(x: screen_width - 40, y: 0, width: 40, height: self.titleLabel.height))
        closeBtn.addTarget(self, action: #selector(cloesAction), for: UIControlEvents.touchUpInside)
        closeBtn.setImage(UIImage(named: "IconBoneDrawer.bundle/close"), for: UIControlState.normal)
        return closeBtn
    }()
    /// 列表
    fileprivate func getTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect(x: 0, y: self.titleLabel.bottom, width: self.width, height: self.height - self.titleLabel.bottom), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.separatorColor = UIColor(colorLiteralRed: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        return tableView
    }
    
    fileprivate var tableView: UITableView!
    fileprivate var background: UIView!
    fileprivate var menuView: UIView!
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.isHidden = true
        
        self.background = UIView(frame: self.bounds)
        self.background.alpha = 0
        self.background.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.1)
        self.addSubview(self.background)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cloesAction))
        tapGesture.numberOfTapsRequired = 1
        self.background.addGestureRecognizer(tapGesture)
        
        self.menuView = UIView(frame: CGRect(x: 0, y: self.height, width: self.width, height: 300))
        self.menuView.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
//        self.menuView.layer.shadowColor = UIColor.black.cgColor //按钮阴影颜色
//        self.menuView.layer.shadowOffset = CGSize(width: 0, height: 0) // 按钮阴影偏移量
//        self.menuView.layer.shadowOpacity = 0.1 // 阴影的透明度，默认是0   范围 0-1 越大越不透明
//        self.menuView.layer.shadowRadius = 2
        self.addSubview(self.menuView)
        
        self.lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 0.5))
        self.lineView.backgroundColor = UIColor(colorLiteralRed: 210/255, green: 210/255, blue: 210/255, alpha: 1)
        self.menuView.addSubview(self.lineView)
        
        self.titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.width - 30, height: 45))
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.textColor = UIColor.darkGray
        self.menuView.addSubview(self.titleLabel)
        
        self.menuView.addSubview(self.closeBtn)
        self.menuView.addSubview(self.cleanBtn)
        
        self.tableView = self.getTableView()
        self.menuView.addSubview(self.tableView)
        
        
//        UIApplication.shared.keyWindow?.addSubview(self)
    }
    

    @objc fileprivate func cloesAction() {
        self.isShow = false
    }
    
    /// 显示动画
    fileprivate func showAnimate() {
        
        self.isHidden = false
        self.menuView.isHidden = false
        self.background.isHidden = false
        UIView.animate(withDuration: self.interval, animations: {
            self.background.alpha = 1
            self.menuView.transform = CGAffineTransform(translationX: 0, y: -self.menuView.height)
        }) { (finished) in
            
        }
    }
    
    /// 隐藏动画
    @objc fileprivate func hideAnimate() {
        UIView.animate(withDuration: self.interval, animations: {
            self.menuView.transform = CGAffineTransform.identity
            self.background.alpha = 0
        }) { (finished) in
            self.menuView.isHidden = true
            self.background.isHidden = true
            self.isHidden = true
        }
    }
}


extension BoneDrawerMenu: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = BoneDrawerMenu.indexPath()
        index.row = indexPath.row
        let type = self.delegate?.drawerMenu(self, cellType: index)
        if type == .text {
            index.detail = ""
            self.delegate?.drawerMenu(self, didSelectRowAt: index)
            self.cloesAction()
        }
    }
}

extension BoneDrawerMenu: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = BoneDrawerMenu.indexPath()
        index.row = indexPath.row
        if let type = self.delegate?.drawerMenu(self, cellType: index) {
            switch type {
            case .onlySelect:
                return BoneDrawerOnlyCell.tableView(tableView: tableView, indexPath: indexPath)
            case .multiSelect:
                return BoneDrawerMultiCell.tableView(tableView: tableView, indexPath: indexPath)
            case .switch, .text:
                return BoneDrawerCell.getHeight
            }
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.numberOfRows(self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "BoneDrawerCell\(indexPath.row)"
        let index = BoneDrawerMenu.indexPath()
        index.row = indexPath.row
        if let type = self.delegate?.drawerMenu(self, cellType: index) {
            switch type {
            case .onlySelect:
                var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoneDrawerOnlyCell
                if cell == nil {
                    cell = BoneDrawerOnlyCell(style: .default, reuseIdentifier: identifier)
                    cell?.title = self.delegate?.drawerMenu(self, title: index)
                    cell?.selectColor = self.selectColor
                    cell?.normalColor = self.normalColor
                    if let items = self.delegate?.drawerMenu(self, items: index) as? [String] {
                        cell?.itemArray = items
                    }
                }
                
                let selectNum = self.delegate?.drawerMenu(self, didSelectItems: index) as? Int
                cell?.selectNum = selectNum ?? 0
                cell?.cellback = { id in
                    index.item = id
                    self.delegate?.drawerMenu(self, didSelectRowAt: index)
                }
                return cell!
                
            case .multiSelect:
                var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoneDrawerMultiCell
                if cell == nil {
                    cell = BoneDrawerMultiCell(style: .default, reuseIdentifier: identifier)
                    cell?.title = self.delegate?.drawerMenu(self, title: index)
                    cell?.selectColor = self.selectColor
                    cell?.normalColor = self.normalColor
                    if let items = self.delegate?.drawerMenu(self, items: index) as? [String] {
                        cell?.itemArray = items
                    }
                }
                
                let seleIds = self.delegate?.drawerMenu(self, didSelectItems: index) as? [Int]
                cell?.ids = seleIds ?? [Int]()
                cell?.cellback = { ids in
                    index.items = ids
                    self.delegate?.drawerMenu(self, didSelectRowAt: index)
                }
                return cell!
                
            case .switch:
                var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoneDrawerCell
                if cell == nil {
                    cell = BoneDrawerCell(style: .default, reuseIdentifier: identifier)
                    cell?.textLabel?.text = self.delegate?.drawerMenu(self, title: index)
                    cell?.switchBtn.isHidden = false
                }
                let seleOn = self.delegate?.drawerMenu(self, didSelectItems: index) as? Bool
                let on = self.delegate?.drawerMenu(self, items: index) as? Bool
                cell?.on = seleOn ?? (on ?? false)
                cell?.cellback = { on in
                    index.on = on
                    self.delegate?.drawerMenu(self, didSelectRowAt: index)
                }
                return cell!
                
            case .text:
                var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoneDrawerCell
                if cell == nil {
                    cell = BoneDrawerCell(style: .value1, reuseIdentifier: identifier)
                    cell?.textLabel?.text = self.delegate?.drawerMenu(self, title: index)
                    cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                }
                let seleText = self.delegate?.drawerMenu(self, didSelectItems: index) as? String
                let text = self.delegate?.drawerMenu(self, items: index) as? String
                cell?.detailTextLabel?.text = seleText ?? text
                return cell!
            }
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BoneDrawerOnlyCell
        if cell == nil {
            cell = BoneDrawerOnlyCell(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }
}
