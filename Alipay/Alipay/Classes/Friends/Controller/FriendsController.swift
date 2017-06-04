//
//  FriendsController.swift
//  Alipay
//
//  Created by Liu Chuan on 2017/5/12.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class FriendsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configNavigationBar()

    }
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 设置导航栏标题文字颜色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // 设置导航栏背景色
//        navigationController?.navigationBar.barTintColor = LightBlue
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        
        /* 右边的Item */
        
        /// 通讯录按钮
        let addressBook = UIButton()
        addressBook.setImage(UIImage(named: "home_contacts"), for: .normal)
        addressBook.sizeToFit()
        addressBook.addTarget(self, action: #selector(addressBookBtnClicked), for: .touchUpInside)
        
        /// 加号按钮
        let addBtn = UIButton()
        addBtn.setImage(UIImage(named: "ap_more"), for: .normal)
        addBtn.sizeToFit()
        addBtn.addTarget(self, action: #selector(addressBookBtnClicked), for: .touchUpInside)
        
        let addBtnItem = UIBarButtonItem(customView: addBtn)
        let addressBookItem = UIBarButtonItem(customView: addressBook)
        
        navigationItem.rightBarButtonItems = [addBtnItem, addressBookItem]
        
    }
    
    // 通讯录按钮点击事件
    @objc private func addressBookBtnClicked() {
        
    }

}
