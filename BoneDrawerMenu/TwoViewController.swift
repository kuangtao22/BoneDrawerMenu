//
//  TwoViewController.swift
//  BoneDrawerMenu
//
//  Created by 俞旭涛 on 2017/6/1.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {
    
    typealias touchUpInside = (_ string: String) -> Void

    var cellback: touchUpInside?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        let button = UIButton(frame: CGRect(x: 30, y: 80, width: screen_width - 60, height: 50))
        button.setTitle("获取·皮皮虾我们走·", for: UIControlState.normal)
        button.addTarget(self, action: #selector(action(button:)), for: UIControlEvents.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.orange, for: UIControlState.normal)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func action(button: UIButton) {
        self.cellback?("皮皮虾我们走")
        _ = self.navigationController?.popViewController(animated: true)
    }
}
