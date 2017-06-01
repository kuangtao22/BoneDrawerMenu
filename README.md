# BoneZoomImage 图片放大器
![github](https://github.com/kuangtao22/BoneImagePreview/blob/master/%E9%A2%84%E8%A7%88.gif
 "github")  
## 简介
BoneDrawerMenu是纯swift写的可自定义底部菜单栏，已经写了第三个了，有写的不好的地方请指正~~~

#### 

	

## 环境要求

* iOS 7.0+
* Xcode 8 (Swift 3) 版

## BoneZoomImage
* 使用方法

		self.menu = BoneDrawerMenu() 
		self.menu.delegate = self		
      	self.menu.drawerHeight = 300		      // 菜单总高度
      	self.menu.titleText = "筛选"	             // 菜单标题
      	self.menu.selectColor = UIColor.orange     // 选中颜色
      	self.menu.normalColor = UIColor.lightGray  // 默认颜色
      	self.view.addSubview(self.menu)
      	
本方法支持父视图下的图片预览、tableViewCell下的图片预览
		
--
 
* 四种表单类型

		enum CellType {
			case multiSelect
        	case onlySelect
       	case `switch`
        	case text
    	}
    	
> 注意事项: 
> 
* 每个CellType对于的类型必须一一对应，详情请参考demo

--

* 代理协议(参考了UITableView的代理方式)

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
    	

