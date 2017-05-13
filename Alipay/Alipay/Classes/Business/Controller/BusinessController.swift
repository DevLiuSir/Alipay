//
//  BusinessController.swift
//  Alipay
//
//  Created by Liu Chuan on 2017/5/12.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class BusinessController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationBar()
    }
    
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 设置导航栏背景色
        navigationController?.navigationBar.barTintColor = LightBlue
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
    }

    

}
