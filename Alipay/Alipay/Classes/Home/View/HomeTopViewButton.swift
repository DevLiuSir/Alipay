//
//  HomeTopViewButton.swift
//  Alipay
//
//  Created by Liu Chuan on 2017/5/12.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/* UIControl内置了 touchupInsed 事件响应*/
/// 顶部功能视图按钮
class HomeTopViewButton: UIControl {

    // MARK: - 控件属性
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 使用图像名称/标题创建按钮, 使用 XIB 布局\加载 按钮.
    ///
    /// - Parameters:
    ///   - imageName: 图像名称
    ///   - title: 标题文字
    /// - Returns: composeTypeButton
    class func homeTopViewButton(imageName: String, title: String) -> HomeTopViewButton {
        
        let nib = UINib(nibName: "HomeTopViewButton", bundle: nil)
        
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! HomeTopViewButton
        
        btn.imageView.image = UIImage(named: imageName)
        
        btn.titleLabel.text = title
        
        return btn
    }
    
   
    class func setTitleColor(_ color: UIColor?, for state: UIControlState) {
    
        
    
    }


}
