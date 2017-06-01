//
//  BoneDrawerMenuDelegate.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/5/31.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

typealias BoneDrawerOnlyCellback = (_ id: Int) -> Void
typealias BoneDrawerMultiCellback = (_ ids: [Int]) -> Void
typealias BoneDrawerSwitchCellback = (_ on: Bool) -> Void

protocol BoneDrawerMenuDelegate: NSObjectProtocol {
    
    
    
    /// 设置每行Cell样式方法
    ///
    /// - Parameters:
    ///   - drawerMenu: drawerMenu description
    ///   - indexPath: indexPath description
    /// - Returns: 样式
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, cellType indexPath: BoneDrawerMenu.indexPath) -> BoneDrawerMenu.CellType
    
    
    
    /// 设置每行Cell标题
    ///
    /// - Parameters:
    ///   - drawerMenu: drawerMenu description
    ///   - indexPath: indexPath description
    /// - Returns: 标题
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, title indexPath: BoneDrawerMenu.indexPath) -> String?
    
    
    
    /// 设置总行数
    ///
    /// - Parameter drawerMenu: drawerMenu description
    /// - Returns: 总行数
    func numberOfRows(_ drawerMenu: BoneDrawerMenu) -> Int
    
    
    
    /// 设置数据源
    ///
    /// - Parameters:
    ///   - drawerMenu: drawerMenu description
    ///   - indexPath: indexPath description
    /// - Returns: 返回[String]/String/Bool
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, items indexPath: BoneDrawerMenu.indexPath) -> Any?
    
    
    
    /// 设置选中数据
    ///
    /// - Parameters:
    ///   - drawerMenu: drawerMenu description
    ///   - indexPath: indexPath description
    /// - Returns: 返回[String]/String/Bool
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, didSelectItems indexPath: BoneDrawerMenu.indexPath) -> Any?
    
    
    
    /// 点击事件
    ///
    /// - Parameters:
    ///   - drawerMenu: drawerMenu description
    ///   - indexPath: indexPath description
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, didSelectRowAt indexPath: BoneDrawerMenu.indexPath)
    
    
    
    /// 重置选中数据
    ///
    /// - Parameter drawerMenu: drawerMenu description
    func cleanData(_ drawerMenu: BoneDrawerMenu)
}

extension BoneDrawerMenuDelegate {
    
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, title indexPath: BoneDrawerMenu.indexPath) -> String? {
        return nil
    }
    
    func drawerMenu(_ drawerMenu: BoneDrawerMenu, didSelectRowAt indexPath: BoneDrawerMenu.indexPath) {
        
    }
}
